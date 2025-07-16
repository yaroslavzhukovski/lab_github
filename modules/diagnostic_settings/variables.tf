variable "name" {
  description = "Name of the diagnostic setting"
  type        = string
}

variable "target_resource_id" {
  description = "ID of the resource to apply diagnostics to"
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "ID of the Log Analytics workspace"
  type        = string
}

variable "logs" {
  description = "List of log categories to enable"
  type        = list(string)
  default     = []
}

variable "metrics" {
  description = "List of metric categories to enable"
  type        = list(string)
  default     = []
}
