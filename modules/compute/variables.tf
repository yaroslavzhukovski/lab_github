variable "location" {
  description = "The Azure region where resources will be created."
  type        = string

}

variable "environment" {
  description = "The environment for the resources (e.g., dev, test, prod)."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "admin_username" {
  description = "The admin username for the virtual machines."
  type        = string
}

variable "admin_password" {
  description = "The admin password for the virtual machines."
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet where the virtual machines will be deployed."
  type        = string
}

variable "ssh_public_key" {
  description = "The SSH public key for the virtual machines."
  type        = string
}
