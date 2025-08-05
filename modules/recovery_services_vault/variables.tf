variable "name" {
  description = "The name of the Recovery Services Vault."
  type        = string

}

variable "location" {
  description = "The location of the Recovery Services Vault."
  type        = string

}

variable "resource_group_name" {
  description = "The name of the resource group where the Recovery Services Vault will be created."
  type        = string

}

variable "sku" {
  description = "The SKU of the Recovery Services Vault."
  type        = string
  default     = "Standard"
}   
