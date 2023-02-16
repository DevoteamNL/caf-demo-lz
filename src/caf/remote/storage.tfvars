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