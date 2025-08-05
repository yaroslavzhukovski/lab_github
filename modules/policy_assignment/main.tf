resource "azurerm_policy_assignment" "this" {
  name                 = var.name
  display_name         = var.display_name
  policy_definition_id = var.policy_definition_id
  scope                = var.scope

  # Optional parameters map
  parameters = var.parameters
}
