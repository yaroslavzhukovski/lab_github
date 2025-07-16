variable "location" {
  description = "The Azure region where the Log Analytics workspace will be deployed."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the Log Analytics workspace will be deployed."
  type        = string
}
variable "application_name" {
  description = "The name of the application for which the Log Analytics workspace is being created."
  type        = string
}
variable "environment" {
  description = "The environment for which the Log Analytics workspace is being created (e.g., dev, prod)."
  type        = string
}
