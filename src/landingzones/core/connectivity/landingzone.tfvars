landingzone = {
  backend_type = "azurerm"
  key          = "connectivity"
  environment  = "production"
  tfstates = {
    current = {      
      storage_account_name = "uzexstconnctivityeoui"
      container_name       = "tfstate"
      resource_group_name  = "uzex-rg-caf-connectivity-syhw"
      key                  = "caf_connectivity.tfsate"
      tenant_id            = "95f1c0e9-c50b-4882-87de-bb2470f0d5ad"
      subscription_id      = "c1cbea85-2d1c-4f36-a6d7-636df95de7e0"
    }
  }
}


backend = {
  tenant_id       = "95f1c0e9-c50b-4882-87de-bb2470f0d5ad"
  subscription_id = "c1cbea85-2d1c-4f36-a6d7-636df95de7e0"
  client_id       = "e6c0bbdc-82d2-4fbf-9dec-35e3cd4b2e24"
  client_secret   = "ur_8Q~g7yiq7u4iLSshsBcza8UK9loiHQzXolcxn"
}


resource_groups = {
  hub-rg = {
    name     = "conn-hub-rg"
    location = "region1"

  }
}

storage_accounts = {
  //Connectivity Terraform State Storage Account  
  connectivity = {
    name                      = "l0"
    resource_group_key        = "hub-rg"
    account_kind              = "BlobStorage"
    account_tier              = "Standard"
    shared_access_key_enabled = false
    account_replication_type  = "GRS" //Global replication
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

networking = {


  #**************************************************************#
  #VIRTUAL NETWORK***********************************************#
  #**************************************************************#
  vnets = {
    hub_re1 = {
      resource_group_key = "hub-rg"
      region             = "region1"
      vnet = {
        name          = "hub-re1"
        address_space = ["100.64.100.0/22"]
      }
      specialsubnets = {
        GatewaySubnet = {
          name = "GatewaySubnet" #Must be called GateWaySubnet in order to host a Virtual Network Gateway
          cidr = ["100.64.100.0/27"]
        }
        AzureFirewallSubnet = {
          name = "AzureFirewallSubnet" #Must be called AzureFirewallSubnet
          cidr = ["100.64.101.0/26"]
        }
      }
      subnets = {
        AzureBastionSubnet = {
          name    = "AzureBastionSubnet" #Must be called AzureBastionSubnet
          cidr    = ["100.64.101.64/26"]
          nsg_key = "azure_bastion_nsg"
        }
        jumpbox = {
          name    = "jumpbox"
          cidr    = ["100.64.102.0/27"]
          nsg_key = "jumpbox"
        }
        jumpbox = {
          name    = "nonprod"
          cidr    = ["100.64.103.0/27"]
          nsg_key = "lznonprod"
        }
        private_endpoints = {
          name                                           = "private_endpoints"
          cidr                                           = ["100.64.103.128/25"]
          enforce_private_link_endpoint_network_policies = true
        }
      }
    }
  }
}


