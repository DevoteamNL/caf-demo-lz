terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }

  backend "azurerm" {
        resource_group_name  = "rg-tfstate-nonprod-001"
        storage_account_name = "sttfstatenonprod001"
        container_name       = "tfstate-nonprod"
        key                  = var.non_prod_remotestate_storagekey
    }
}
