terraform {
  required_version = ">= 0.15"
  required_providers {
    // azurerm version driven by the caf module
    // azuread version driven by the caf module
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
}


provider "azurerm" {  
  partner_id = "ca4078f8-9bc4-471b-ab5b-3af6b86a42c8"
  client_id = var.azurerm_client_id
  client_secret = var.azurerm_client_secret
  subscription_id = var.subscription_id
  tenant_id = var.tenant_id
  # partner identifier for CAF Terraform landing zones.
  features {}
}

resource "random_string" "prefix" {
  count   = var.prefix == null ? 1 : 0
  length  = 4
  special = false
  upper   = false
  number  = false
}

locals {
  landingzone_tag = {
    "landingzone" = var.landingzone.key
  }
  client_id = var.azurerm_client_id
  tags = merge(local.global_settings.tags, local.landingzone_tag, { "environment" = local.global_settings.environment },  var.tags)

  global_settings = {
    default_region     = var.default_region
    environment        = var.environment
    inherit_tags       = var.inherit_tags
    passthrough        = var.passthrough
    prefix             = var.prefix
    prefixes           = var.prefix == "" ? null : [try(random_string.prefix.0.result, var.prefix)]
    prefix_with_hyphen = var.prefix == "" ? null : format("%s", try(random_string.prefix.0.result, var.prefix))
    random_length      = var.random_length
    regions            = var.regions
    tags               = var.tags
    use_slug           = var.use_slug
  }

  tfstates = tomap(
    {
      (var.landingzone.key) = local.backend[var.landingzone.backend_type]
    }
  )

  backend = {
    azurerm = {
      storage_account_name = module.landingzones.storage_accounts[var.landingzone.key].name
      container_name       = module.landingzones.storage_accounts[var.landingzone.key].containers["tfstate"].name
      resource_group_name  = module.landingzones.storage_accounts[var.landingzone.key].resource_group_name
      key                  = var.tf_name
      level                = "level0"
      tenant_id            = data.azurerm_client_config.current.tenant_id
      subscription_id      = data.azurerm_client_config.current.subscription_id
    }
  }

}

data "azurerm_client_config" "current" {}