output "subnet_ids" {
  value = {
    for key, subnet in azurerm_subnet.custom : key => subnet.id
  }
}
