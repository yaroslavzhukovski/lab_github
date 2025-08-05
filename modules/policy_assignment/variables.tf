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
  description = "The scope for the policy assignment (management group, subscription, resource group, or resource)."
  type        = string
}
variable "parameters" {
  description = "Optional parameters for the policy assignment, if required by the policy definition."
  type        = map(any)
  default     = null

}
