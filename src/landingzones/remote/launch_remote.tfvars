

tenant_id             = "95f1c0e9-c50b-4882-87de-bb2470f0d5ad"
subscription_id       = "c1cbea85-2d1c-4f36-a6d7-636df95de7e0"
azurerm_client_id     = "e6c0bbdc-82d2-4fbf-9dec-35e3cd4b2e24"
azurerm_client_secret = "ur_8Q~g7yiq7u4iLSshsBcza8UK9loiHQzXolcxn"

launcher = {
  key          = "caf_launcher"
  backend_type = "azurerm"
  environment  = "caf"
  remote_setup_key_names = {
    tfstates = [
      "connectivity",
      "nonprod"
    ]
  }
}

resource_groups = {
  rg-connectivity = {
    name   = "caf-connectivity"
    region = "region1"
  }
  rg-workload-nonprod = {
    name   = "caf-nonprod"
    region = "region1"
  }
}

storage_accounts = {
  connectivity = {
    name                      = "connctivity"
    resource_group_key        = "rg-connectivity"
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
    tags = {
      caf_environment = "budget-thuis"
      caf_tfstate     = "connectivity"
    }
  }

  workload_nonprod = {
    name                      = "nonprod"
    resource_group_key        = "rg-workload-nonprod"
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
    tags = {
      caf_environment = "budget-thuis"
      caf_tfstate     = "nonprod"
    }
  }
}
