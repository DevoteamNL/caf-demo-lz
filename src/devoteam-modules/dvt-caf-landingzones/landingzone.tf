module "landingzone" {
  source = "../dvt-caf"
  providers = {
    azurerm.vhub = azurerm.vhub
  }
  current_landingzone_key  = var.landingzone.key
  global_settings          = var.global_settings
  logged_user_objectId     = var.logged_user_objectId
  logged_aad_app_objectId  = var.logged_aad_app_objectId
  subscriptions            = var.subscriptions
  tenant_id                = try(var.backend.tenant_id, var.tenant_id)
  subscription_id          = try(var.backend.subscription_id, var.subscription_id)
  azurerm_client_id        = try(var.backend.client_id, var.azurerm_client_id)
  azurerm_client_secret    = try(var.backend.client_secret, var.azurerm_client_secret)
  resource_groups          = var.resource_groups
  storage_accounts         = var.storage_accounts
  networking               = var.networking
  compute                  = var.compute
  tfstates                 = var.landingzone.tfstates
  database                 = var.database
  remote_objects           = local.remote
  keyvaults                = var.keyvaults
  managed_identities       = var.managed_identities
  keyvault_access_policies = var.keyvault_access_policies
}
