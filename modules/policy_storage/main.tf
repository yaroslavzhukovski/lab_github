resource "azurerm_policy_assignment" "storage_https" {
  name                 = "enforce-https-storage"
  display_name         = "Enforce HTTPS for Storage Accounts"
  scope                = var.scope
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/0a914174-19dd-4b94-8c87-e24f5e4ff4c5" # Built-in: Only allow HTTPS traffic

  parameters = jsonencode({})
}

resource "azurerm_policy_assignment" "storage_no_public_blob" {
  name                 = "deny-public-blob"
  display_name         = "Deny Public Blob Access"
  scope                = var.scope
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/2f3a2b96-737d-4e76-8f8d-8bbac5c4f7ab" # Built-in: Public blob access should be disallowed

  parameters = jsonencode({})
}
