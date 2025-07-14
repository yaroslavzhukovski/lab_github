resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "custom" {
  for_each = var.subnets

  name                 = each.value.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [each.value.address_prefix]
}

resource "azurerm_route_table" "firewall_route" {
  name                = "rt-firewall"
  location            = var.location
  resource_group_name = var.resource_group_name

  route {
    name                   = "force-to-fw"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = var.firewall_private_ip
  }
}

resource "azurerm_subnet_route_table_association" "bravo_subnet_assoc" {
  subnet_id      = azurerm_subnet.custom["bravo"].id
  route_table_id = azurerm_route_table.firewall_route.id
}
