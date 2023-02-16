locals {
  landingzone = {
    current = {
      storage_account_name = var.landingzone.tfstates["current"].storage_account_name
      container_name       = var.landingzone.tfstates["current"].container_name
      resource_group_name  = var.landingzone.tfstates["current"].resource_group_name
      client_id            = var.landingzone.tfstates["current"].client_id
      client_secret        = var.landingzone.tfstates["current"].client_secret
    }
    lower = {
      storage_account_name = try(var.landingzone.tfstates["lower"].storage_account_name, null)
      container_name       = try(var.landingzone.tfstates["lower"].container_name, null)
      resource_group_name  = try(var.landingzone.tfstates["lower"].resource_group_name, null)
      client_id            = try(var.landingzone.tfstates["lower"].client_id, null)
      client_secret        = try(var.landingzone.tfstates["lower"].client_secret, null)
    }
  }
}

data "terraform_remote_state" "remote" {
  for_each = try(var.landingzone.tfstates, {})

  backend = try(each.value.backend_type, var.landingzone.backend_type, "azurerm")
  config  = local.remote_state[try(each.value.backend_type, var.landingzone.backend_type, "azurerm")][each.key]
}

locals {

  remote_state = {
    azurerm = {
      for key, value in try(var.landingzone.tfstates, {}) : key => {
        container_name       = value.container_name
        key                  = value.key
        resource_group_name  = value.resource_group_name
        storage_account_name = value.storage_account_name
        subscription_id      = value.subscription_id
        tenant_id            = value.tenant_id
        client_id            = value.client_id
        client_secret        = value.client_secret
        
      }
    }
  }

  tags = merge(try(local.global_settings.tags, {}), try({ "environment" = local.global_settings.environment }, {}), var.tags)

  global_settings = merge(
    var.global_settings,
    try(data.terraform_remote_state.remote[var.landingzone.global_settings_key].outputs.objects[var.landingzone.global_settings_key].global_settings, null),
    try(data.terraform_remote_state.remote[var.landingzone.global_settings_key].outputs.global_settings, null),
    try(data.terraform_remote_state.remote[keys(var.landingzone.tfstates)[0]].outputs.global_settings, null)
  ) 
  

}
