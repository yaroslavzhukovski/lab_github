variable "client_id" {
  description = "The client ID for the Azure service principal."
  type        = string

}

variable "tenant_id" {
  description = "The tenant ID for the Azure service principal."
  type        = string
}

variable "subscription_id" {
  description = "The subscription ID for the Azure resources."
  type        = string
}

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
