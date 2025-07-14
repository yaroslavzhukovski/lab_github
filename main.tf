resource "azurerm_resource_group" "main" {
  name     = "rg-${var.application_name}-${var.environment}"
  location = var.location
}




locals {
  bastion_address_space = cidrsubnet(var.base_address_space, 4, 0)
  bravo_address_space   = cidrsubnet(var.base_address_space, 2, 1)
  #charlie_address_space = cidrsubnet(var.base_address_space, 2, 2)
  firewall_address_space = cidrsubnet(var.base_address_space, 2, 3)
}

module "network" {
  source              = "./modules/network"
  vnet_name           = "vnet-${var.application_name}-${var.environment}"
  address_space       = [var.base_address_space]
  firewall_private_ip = var.firewall_private_ip
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name

  subnets = {
    bravo = {
      name           = "bravo"
      address_prefix = local.bravo_address_space
    }
    firewall = {
      name           = "AzureFirewallSubnet"
      address_prefix = local.firewall_address_space
    }
    bastion = {
      name           = "AzureBastionSubnet"
      address_prefix = local.bastion_address_space
    }
  }
}
