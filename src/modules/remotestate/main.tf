

resource "azurerm_resource_group" "tfstate-rg" {
  name     = "tfstatenonprod"
  location = "West Europe"
}

resource "azurerm_storage_account" "tfstate" {
  name                     = "mmtfstatenonprod"
  resource_group_name      = azurerm_resource_group.tfstate-rg.name
  location                 = azurerm_resource_group.tfstate-rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_blob_public_access = false

  tags = {
    environment = "staging"
  }
}

resource "azurerm_storage_container" "tfstate-stg" {
  name                  = "tfstate-staging"
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "private"
}



resource "azurerm_storage_container" "tfstate-qa" {
  name                  = "tfstate-qa"
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "private"
}

