variable "name" {
  description = "The name of the policy assignment."
  type        = string
}

variable "display_name" {
  description = "Display name for the policy assignment."
  type        = string
}

variable "policy_definition_id" {
  description = "ID of the built-in or custom policy definition."
  type        = string
}

variable "scope" {
  description = "Resource group ID where the policy will be applied."
  type        = string
}

variable "parameters" {
  description = "Optional parameters for the policy assignment."
  type        = map(any)
  default     = {}
}
