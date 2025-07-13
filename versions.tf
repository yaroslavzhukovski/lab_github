terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.34.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.7.2"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.4.0"
    }
  }

  backend "azurerm" {
    use_oidc             = true
    use_azuread_auth     = true
    storage_account_name = "sto12b7idvrj"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
  }
}





provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
      recover_soft_deleted_secrets = true
    }

  }
}


