terraform {
  required_version = ">= 0.15"
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
  backend "azurerm" {
        resource_group_name  = var.tfstate_resource_group_name
        storage_account_name = var.tfstate_storage_account_name
        container_name       = var.tfstate_container_name
        key                  = var.tfstate_key
    }
}


provider "azurerm" {  
  features {}  
}

locals { 
  global_settings =  var.global_settings
  tfstates = tomap(
    {
      (var.launcher.key) = local.backend[var.launcher.backend_type]
    }
  )
  backend = {
    azurerm = {
      storage_account_name = module.dvt-caf-launcher.storage_accounts[var.launcher.remote_setup_key_names.tfstates[0]].name
      container_name       = module.dvt-caf-launcher.storage_accounts[var.launcher.remote_setup_key_names.tfstates[0]].containers["tfstate"].name
      resource_group_name  = module.dvt-caf-launcher.storage_accounts[var.launcher.remote_setup_key_names.tfstates[0]].resource_group_name
      key                  = var.tf_name    
      tenant_id            = data.azurerm_client_config.current.tenant_id
      subscription_id      = data.azurerm_client_config.current.subscription_id
    }
  }

}

data "azurerm_client_config" "current" {}


module "dvt-caf-launcher" {
  source  = "../dvt-caf" 
  providers = {
    azurerm.vhub = azurerm
  }
  global_settings                       = var.global_settings
  current_landingzone_key               = "caf_launcher"    
  logged_aad_app_objectId               = var.azurerm_client_id
  logged_user_objectId                  = var.azurerm_client_id  
  resource_groups                       = var.resource_groups  
  storage_accounts                      = var.storage_accounts  
  tenant_id                             = var.tenant_id
  user_type                             = var.global_settings.user_type  
}
