variable "vnet_name" {
  description = "The name of the virtual network."
  type        = string

}

variable "address_space" {
  description = "The address space for the virtual network."
  type        = list(string)

}

variable "location" {
  description = "The Azure region where resources will be created."
  type        = string

}

variable "resource_group_name" {
  description = "The name of the resource group where the network resources will be created."
  type        = string

}

variable "firewall_private_ip" {
  description = "The private IP address of the firewall."
  type        = string

}

variable "address_prefixes" {
  description = "The address prefixes for the VM subnet."
  type        = list(string)
}

variable "subnets" {
  description = "A map of subnets to be created in the virtual network."
  type = map(object({
    name           = string
    address_prefix = string
  }))

}
