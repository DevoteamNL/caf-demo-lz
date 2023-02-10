terraform {
    required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.99.0"
      configuration_aliases = [
        azurerm.vhub
      ]
    }
  }
}


provider "azurerm" {
  alias = "vhub"
  subscription_id = "c1cbea85-2d1c-4f36-a6d7-636df95de7e0"
  tenant_id = "95f1c0e9-c50b-4882-87de-bb2470f0d5ad"
  client_id = "c76dfb9d-243c-402c-a607-2d40f48f0061"
  client_secret = "lC68Q~Q5EH4B95m3zAlOW4eJoB8YtPQHylDFQb0w"  
  features {}
}




module "dvt-caf" {
    source = "../../../dvt-caf"    
    providers = {
        azurerm.vhub = azurerm.vhub
    }
    global_settings = var.global_settings
    resource_groups = var.resource_groups
    logged_user_objectId = "c76dfb9d-243c-402c-a607-2d40f48f0061"    
    current_landingzone_key = "nonprod"
    tenant_id = "95f1c0e9-c50b-4882-87de-bb2470f0d5ad"
    keyvaults = var.keyvaults
    compute = {
      aks_clusters = var.aks_clusters
      azure_container_registries = var.azure_container_registries
    }
    networking = {
        vnets = var.vnets        
    }

}

