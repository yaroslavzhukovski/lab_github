output "https_only_policy_id" {
  value = azurerm_policy_definition.https_only.id
}

output "public_access_deny_policy_id" {
  value = azurerm_policy_definition.public_access_deny.id
}
output "https_only_assignment_id" {
  value = azurerm_policy_assignment.https_only_assign.id
}

output "public_access_deny_assignment_id" {
  value = azurerm_policy_assignment.public_access_deny_assign.id
}
