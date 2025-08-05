resource "azurerm_resource_policy_assignment" "this" {
  name                 = var.name
  display_name         = var.display_name
  policy_definition_id = var.policy_definition_id
  scope                = var.scope

  # Optional: parameters can be passed if policy requires them
  dynamic "parameters" {
    for_each = var.parameters != null ? [var.parameters] : []
    content {
      # This assumes parameters is a JSON string
      value = parameters.value
    }
  }
}
