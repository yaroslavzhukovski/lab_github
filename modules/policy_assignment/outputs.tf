output "policy_assignment_id" {
  description = "ID of the created policy assignment."
  value       = azurerm_resource_policy_assignment.this.id
}
