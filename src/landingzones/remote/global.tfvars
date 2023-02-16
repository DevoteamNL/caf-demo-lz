landingzone = {
  backend_type = "azurerm"
  level        = "level0"
  key          = "remote-setup"
}
passthrough = false
inherit_tags = false
random_length = 3
prefix = "caf"
default_region = "region1"
regions = {
  region1 = "westeurope"
  region2 = "northeurope"
}

resource_groups = {
  rg-connectivity = {
    name   = "caf-connectivity"
    region = "region1"
  }
  rg-workload-nonprod = {
    name   = "caf-nonpror"
    region = "region1"
  }
}


user_type = "user"

environment = "caf"


remote_setup_key_names = {  
  tfstates = [    
    "connectivity",
    "nonprod"
  ]
}

 tenant_id            = "95f1c0e9-c50b-4882-87de-bb2470f0d5ad"
 subscription_id      = "c1cbea85-2d1c-4f36-a6d7-636df95de7e0"
 azurerm_client_id     = "e6c0bbdc-82d2-4fbf-9dec-35e3cd4b2e24"
 azurerm_client_secret = "ur_8Q~g7yiq7u4iLSshsBcza8UK9loiHQzXolcxn"
