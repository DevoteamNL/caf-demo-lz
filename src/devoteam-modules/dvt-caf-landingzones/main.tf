terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.3.1"
    }
    external = {
      source  = "hashicorp/external"
      version = "~> 2.2.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.1.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 3.1.0"
    }
    azurecaf = {
      source  = "aztfmod/azurecaf"
      version = "~> 1.2.0"
    }
  }
  required_version = ">= 0.15"
}

provider "azurerm" {  
  features {}
  subscription_id = try(var.backend.subscription_id, var.subscription_id)
  tenant_id       = try(var.backend.tenant_id, var.tenant_id)
  client_id       = try(var.backend.client_id, var.azurerm_client_id)
  client_secret   = try(var.backend.client_secret, var.azurerm_client_secret)
}

provider "azurerm" {
  alias                      = "vhub"  
  features {}
  subscription_id = try(var.backend.subscription_id, var.subscription_id)
  tenant_id       = try(var.backend.tenant_id, var.tenant_id)
  client_id       = try(var.backend.client_id, var.azurerm_client_id)
  client_secret   = try(var.backend.client_secret, var.azurerm_client_secret)
}

provider "azuread" {  
  tenant_id       = try(var.backend.tenant_id, var.tenant_id)  
}

data "azurerm_client_config" "current" {}


locals {  
  # Update the tfstates map
  tfstates = merge(
    tomap(
      {
        (var.landingzone.key) = local.backend[var.landingzone.backend_type]
      }
    )
    ,
    try(data.terraform_remote_state.remote[var.landingzone.global_settings_key].outputs.tfstates, {})
  )


  backend = {
     azurerm = {
      storage_account_name = var.landingzone.tfstates["current"].storage_account_name
      container_name       = var.landingzone.tfstates["current"].container_name
      resource_group_name  = var.landingzone.tfstates["current"].resource_group_name
      key                  = var.landingzone.tfstates["current"].key      
      tenant_id            = try(var.landingzone.tfstates["current"].tenant_id, var.tenant_id)
      subscription_id      = try(var.landingzone.tfstates["current"].subscription_id, var.subscription_id)
      
    }
  }

}

