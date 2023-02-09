
module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "~> 5.4.0"
  global_settings      = merge((var.override_prefix == "" ? {} : { prefix = var.override_prefix }), var.global_settings)
  logged_user_objectId = "378c623f-60e9-48b1-b062-587ec3a135d5" // RAFAEL AZ AD OBJECT ID (TEST ONLY)var.logged_user_objectId
  tags                 = var.tags
  resource_groups      = var.resource_groups
  keyvaults            = var.keyvaults
  managed_identities   = var.managed_identities
  role_mapping         = var.role_mapping 
  azuread = {
    azuread_groups  = var.azuread_groups
  }
  networking = {
    vnets = var.vnets
  }
  compute = {
    aks_clusters = var.aks_clusters
  }
}