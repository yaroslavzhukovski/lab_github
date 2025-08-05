resource "azurerm_resource_group" "main" {
  name     = "rg-${var.application_name}-${var.environment}"
  location = var.location
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "my_key_vault" {
  name                        = "kvyarikz"
  location                    = azurerm_resource_group.main.location
  resource_group_name         = azurerm_resource_group.main.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name                  = "standard"
  enable_rbac_authorization = true
}


resource "tls_private_key" "scale_set_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "azurerm_key_vault_secret" "scale_set_private_key" {
  name         = "scaleSetSshPrivateKey"
  value        = tls_private_key.scale_set_key.private_key_pem
  key_vault_id = azurerm_key_vault.my_key_vault.id
}

resource "azurerm_key_vault_secret" "scale_set_public_key" {
  name         = "scaleSetSshPublicKey"
  value        = tls_private_key.scale_set_key.public_key_openssh
  key_vault_id = azurerm_key_vault.my_key_vault.id
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

module "firewall" {
  source              = "./modules/firewall"
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  firewall_subnet_id  = module.network.subnet_ids["firewall"]
  application_name    = var.application_name
  environment         = var.environment
}

module "compute" {
  source              = "./modules/compute"
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  environment         = var.environment
  admin_username      = "adminuser"
  ssh_public_key      = azurerm_key_vault_secret.scale_set_public_key.value
  subnet_id           = module.network.subnet_ids["bravo"]

}

resource "azurerm_role_assignment" "vmss_keyvault_reader" {
  principal_id         = module.compute.vmss_identity
  role_definition_name = "Key Vault Secrets User"
  scope                = azurerm_key_vault.my_key_vault.id
}

module "bastion" {
  source              = "./modules/bastion"
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  bastion_subnet_id   = module.network.subnet_ids["bastion"]

}

module "log_analytics_workspace" {
  source              = "./modules/log_analytics_workspace"
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  application_name    = var.application_name
  environment         = var.environment

}

module "firewall_diagnostics" {
  source = "./modules/diagnostic_settings"

  name                       = "diag-fw"
  target_resource_id         = module.firewall.firewall_id
  log_analytics_workspace_id = module.log_analytics_workspace.workspace_id

  log_categories = [
    "AZFWApplicationRule",
    "AZFWNetworkRule",
    "AZFWDnsQuery",
    "AZFWThreatIntel"
  ]

  metric_categories = ["AllMetrics"]
}

module "vmss_diagnostics" {
  source = "./modules/diagnostic_settings"

  name                       = "diag-vmss"
  target_resource_id         = module.compute.vmss_id
  log_analytics_workspace_id = module.log_analytics_workspace.workspace_id

  log_categories = [
    "AuditEvent",
    "SecurityEvent",
    "Syslog"
  ]

  metric_categories = ["AllMetrics"]

}

module "storage" {
  source              = "./modules/storage_account"
  name                = "st${var.environment}1"
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name

  subnet_ids = [module.network.subnet_ids["bravo"],
  module.network.subnet_ids["bastion"]]
}

module "storage_diagnostics" {
  source = "./modules/diagnostic_settings"

  name                       = "diag-storage"
  target_resource_id         = module.storage.storage_account_id
  log_analytics_workspace_id = module.log_analytics_workspace.workspace_id

  log_categories = [
    "StorageRead",
    "StorageWrite",
    "StorageDelete"
  ]

  metric_categories = ["AllMetrics"]

}

module "storage_private_endpoint" {
  source = "./modules/private_endpoint"

  private_endpoint_name = "pe-storage"
  location              = var.location
  resource_group_name   = azurerm_resource_group.main.name

  subnet_id          = module.network.subnet_ids["bravo"]
  target_resource_id = module.storage.storage_account_id
  subresource_names  = ["blob"]

  private_dns_zone_name = "privatelink.blob.core.windows.net"
  virtual_network_id    = module.network.vnet_id
}

module "recovery_vault" {
  source              = "./modules/recovery_services_vault"
  name                = "rsv-${var.application_name}-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
}


module "policy_storage" {
  source = "./modules/policy_storage"
  scope  = azurerm_resource_group.main.id
}
