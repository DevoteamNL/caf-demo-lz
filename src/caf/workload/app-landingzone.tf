provider "azurerm" {  
  subscription_id = var.subscription_id
  tenant_id = var.tenant_id
  client_id = var.client_id
  client_secret = var.client_secret
  features {}
}




#=========================================================#
#============== APPLICATION LANDING ZONE =================#
module "dvt-caf" {
    source = "../../../dvt-caf"        
    global_settings = var.global_settings
    resource_groups = var.resource_groups
    logged_user_objectId = var.client_id   
    current_landingzone_key = "nonprod"
    tenant_id = var.tenant_id
    keyvaults = var.keyvaults
    compute = {
      aks_clusters = var.aks_clusters
      azure_container_registries = var.azure_container_registries
    }
    networking = {
        vnets = var.vnets        
    }

}
