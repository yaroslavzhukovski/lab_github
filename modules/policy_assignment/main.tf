resource "azurerm_resource_group_policy_assignment" "this" {
  name                 = var.name
  display_name         = var.display_name
  policy_definition_id = var.policy_definition_id
  resource_group_id    = var.scope # Scope is now the RG ID

  parameters = var.parameters
}
