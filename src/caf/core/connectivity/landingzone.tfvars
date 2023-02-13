landingzone = {
  backend_type = "azurerm"
  key          = "connectivity"
}

environment = "production"

resource_groups = {
  hub-rg = {
    name     = "conn-hub-rg"
    location = "region1"

  }
}

storage_accounts = {
  connectivity = {
    name                      = "l0"
    resource_group_key        = "hub-rg"
    account_kind              = "BlobStorage"
    account_tier              = "Standard"
    shared_access_key_enabled = false
    account_replication_type  = "GRS"
    blob_properties = {
      versioning_enabled       = true
      last_access_time_enabled = true
      container_delete_retention_policy = {
        days = 7
      }
      delete_retention_policy = {
        days = 7
      }
    }
    containers = {
      tfstate = {
        name = "tfstate"
      }
    }
  }
}




