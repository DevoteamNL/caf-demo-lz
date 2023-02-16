module "dvt-caf-remote-setup" {
  source  = "../dvt-caf" 

  providers = {
    azurerm.vhub = azurerm
  }

  current_landingzone_key               = var.landingzone.key  
  enable                                = var.enable
  log_analytics                         = var.log_analytics
  logged_aad_app_objectId               = var.logged_aad_app_objectId
  logged_user_objectId                  = var.azurerm_client_id
  managed_identities                    = var.managed_identities  
  resource_groups                       = var.resource_groups  
  storage_accounts                      = var.storage_accounts  
  tenant_id                             = var.tenant_id
  user_type                             = var.user_type

  
}
