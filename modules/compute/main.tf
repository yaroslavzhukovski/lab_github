resource "azurerm_public_ip" "lb_pip" {
  name                = "pip-lb-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_lb" "main" {
  name                = "lb-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  frontend_ip_configuration {
    name                 = "frontend"
    public_ip_address_id = azurerm_public_ip.lb_pip.id
  }
}

resource "azurerm_lb_backend_address_pool" "main" {
  name                = "backend-pool"
  loadbalancer_id     = azurerm_lb.main.id
  resource_group_name = var.resource_group_name
}

resource "azurerm_linux_virtual_machine_scale_set" "vmss" {
  name                = "vmss-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard_B2s"
  instances           = 2
  identity {
    type = "SystemAssigned"
  }

  admin_username = var.admin_username
  admin_ssh_key {
    username   = var.admin_username
    public_key = var.ssh_public_key
  }
  disable_password_authentication = true

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  network_interface {
    name    = "nic"
    primary = true

    ip_configuration {
      name                                   = "internal"
      subnet_id                              = var.subnet_id
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.main.id]
      primary                                = true
    }

  }

  upgrade_mode         = "Manual"
  computer_name_prefix = "vmss"

  depends_on = [azurerm_lb_backend_address_pool.main]
}
