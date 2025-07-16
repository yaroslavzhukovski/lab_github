locals {
  logs = [
    for category in var.log_categories : {
      category = category
      enabled  = true
    }
  ]

  metrics = [
    for category in var.metric_categories : {
      category = category
      enabled  = true
    }
  ]
}


resource "azurerm_monitor_diagnostic_setting" "this" {
  name                       = var.name
  target_resource_id         = var.target_resource_id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  dynamic "log" {
    for_each = local.logs
    content {
      category = each.value.category
      enabled  = each.value.enabled


    }
  }

  dynamic "metric" {
    for_each = local.metrics
    content {
      category = each.value.category
      enabled  = each.value.enabled


    }
  }
}
