output "subnet_ids" {
  value = {
    for key, subnet in azurerm_subnet.custom : key => subnet.id
  }
}

output "vnet_id" {
  value = azurerm_virtual_network.vnet.id

}
