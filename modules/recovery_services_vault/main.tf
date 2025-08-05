resource "azurerm_recovery_services_vault" "main" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku

  soft_delete_enabled = true
}
