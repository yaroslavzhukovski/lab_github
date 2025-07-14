variable "location" {
  description = "The Azure region where resources will be created."
  type        = string

}
variable "resource_group_name" {
  description = "The name of the resource group where the firewall resources will be created."
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
variable "firewall_subnet_id" {
  description = "The ID of the subnet where the Azure Firewall will be deployed."
  type        = string

}
