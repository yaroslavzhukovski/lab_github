variable "name" {
  description = "Name of the diagnostic setting"
  type        = string
}

variable "target_resource_id" {
  description = "ID of the resource to enable diagnostics for"
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "ID of the Log Analytics Workspace"
  type        = string
}

variable "log_categories" {
  description = "List of log categories to enable"
  type        = list(string)
}

variable "metric_categories" {
  description = "List of metric categories to enable"
  type        = list(string)
  default     = ["AllMetrics"]
}
