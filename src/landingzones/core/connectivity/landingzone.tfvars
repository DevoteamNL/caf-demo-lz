landingzone = {
  backend_type = "azurerm"
  key          = "connectivity"
  environment  = "production"
  tfstates = {
    current = {
      storage_account_name = "sttfstatebudgetthuis"
      container_name       = "connectivity"
      resource_group_name  = "caf-bt-tfstate-rg"
      tfstate              = "caf_connectivity.tfstate"
    }
  }
}

resource_groups = {
  hub-rg = {
    name     = "conn-hub-rg"
    location = "region1"
  }
}