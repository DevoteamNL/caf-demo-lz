terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = ""
  tenant_id = ""
  client_id = var.az_ad_sp_appId
  client_secret = var.az_ad_sp_secret
}

resource "azurerm_resource_group" "rg-tfstate" {
  name     = "rg-tfstate-nonprod-001"
  location = "West Europe"
}

resource "azurerm_storage_account" "sttfstate" {
  name                     = "sttfstatenonprod001"
  resource_group_name      = azurerm_resource_group.tfstate-rg.name
  location                 = azurerm_resource_group.tfstate-rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_blob_public_access = false

  tags = {
    environment = "Non Production"
  }
}

resource "azurerm_storage_container" "tfstate-nonprod" {
  name                  = "tfstate-nonprod"
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "private"
}




