module "landingzone" {
  source  = "../dvt-caf"
  providers = {
    azurerm.vhub = azurerm.vhub
  }   
  current_landingzone_key               = var.landingzone.key  
  global_settings                       = var.global_settings  
  logged_user_objectId                  = try(var.backend.client_id, var.azurerm_client_id)
  subscriptions                         = var.subscriptions  
  tenant_id                             = try(var.backend.tenant_id, var.tenant_id) 
  resource_groups                       = var.resource_groups
  storage_accounts                      = var.storage_accounts
  networking                            = var.networking 
  compute                               = var.compute
  tfstates                              = var.landingzone.tfstates
}
