variable "name" {
  description = "Name of diagnostic settings"
  type        = string
}

variable "target_resource_id" {
  description = "ID of the target resource (e.g., firewall)"
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "ID of the Log Analytics Workspace"
  type        = string
}

variable "log_categories" {
  description = "List of log categories to enable"
  type        = list(string)
  default     = []
}
