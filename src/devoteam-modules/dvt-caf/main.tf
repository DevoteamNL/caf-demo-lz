
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.99"
      configuration_aliases = [
        azurerm.vhub
      ]
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 1.4.0"
    }
    azapi = {
      source  = "azure/azapi"
      version = "~> 1.0.0"
    }
    azurecaf = {
      source  = "aztfmod/azurecaf"
      version = "~> 1.2.0"
    }
    null = {
      source = "hashicorp/null"
    }
    random = {
      version = "~> 3.3.1"
      source  = "hashicorp/random"
    }
  }
  required_version = ">= 1.1.0"
}

provider "azurerm" {
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
  client_id       = var.azurerm_client_id
  client_secret   = var.azurerm_client_secret
  features {}
}

data "azurerm_subscription" "primary" {
}

data "azurerm_client_config" "current" {    
}


data "azuread_service_principal" "logged_in_app" {
  count          = var.logged_aad_app_objectId == null ? 0 : 1
  application_id = var.logged_aad_app_objectId
}
