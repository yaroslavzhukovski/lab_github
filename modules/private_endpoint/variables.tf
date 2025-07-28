variable "private_endpoint_name" {
  description = "The name of the private endpoint."
  type        = string
}

variable "location" {
  description = "The location where the resources will be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet where the private endpoint will be created."
  type        = string
}

variable "target_resource_id" {
  description = "The ID of the resource (Storage, Key Vault, etc.) to connect to."
  type        = string
}

variable "subresource_names" {
  description = "The names of the subresources to connect to (e.g., ['blob'])."
  type        = list(string)
}

variable "private_dns_zone_name" {
  description = "The name of the private DNS zone."
  type        = string
}

variable "virtual_network_id" {
  description = "The ID of the virtual network."
  type        = string
}
