output "vmss_identity" {
  value = azurerm_linux_virtual_machine_scale_set.vmss.identity[0].principal_id
}

output "vmss_id" {
  value = azurerm_linux_virtual_machine_scale_set.vmss.id

}
