
variable "location" {
  description = "The Azure region where resources will be created."
  type        = string


}

variable "application_name" {
  description = "The name of the application to be created."
  type        = string

}

variable "environment" {
  description = "The environment for the deployment (e.g., prod, dev)."
  type        = string

}



variable "base_address_space" {
  description = "The base address space for the virtual network."
  type        = string

}

variable "firewall_private_ip" {
  description = "The private IP address of the Azure Firewall."
  type        = string

}
