variable "name" {
  description = "Имя diagnostic settings"
  type        = string
}

variable "target_resource_id" {
  description = "ID ресурса, к которому применяются настройки (например, Azure Firewall)"
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "ID Log Analytics Workspace"
  type        = string
}
