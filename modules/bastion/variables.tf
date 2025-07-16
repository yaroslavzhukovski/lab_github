variable "location" {
  description = "The Azure region where the Bastion host will be deployed."
  type        = string


}
variable "resource_group_name" {
  description = "The name of the resource group where the Bastion host will be deployed."
  type        = string
}

variable "bastion_subnet_id" {
  description = "The ID of the subnet where the Bastion host will be deployed."
  type        = string
}
