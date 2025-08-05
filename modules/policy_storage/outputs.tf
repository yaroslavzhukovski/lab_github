output "https_only_assignment_id" {
  value = azurerm_policy_assignment.storage_https.id
}

output "public_access_deny_assignment_id" {
  value = azurerm_policy_assignment.storage_no_public_blob.id
}
