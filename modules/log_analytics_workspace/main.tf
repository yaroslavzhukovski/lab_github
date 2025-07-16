resource "azurerm_log_analytics_workspace" "main" {
  name                = "law-${var.application_name}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}
