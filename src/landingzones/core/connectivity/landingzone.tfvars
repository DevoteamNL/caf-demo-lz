landingzone = {
  backend_type = "azurerm"
  key          = "connectivity"
  environment  = "production"
  tfstates = {
    current = {
      storage_account_name = "sttfstatedvtcaf"
      container_name       = "connectivity"
      resource_group_name  = "caf-tfstate-rg"
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


networking = {
  vnets = {
    hub_vnet = {
      resource_group_key = "hub-rg"
      region             = "region1"
      vnet = {
        name          = "mm-vnet-hub"
        address_space = ["100.64.0.0/20"]#100.64.0.0 - 100.64.15.255 
      }
      specialsubnets = {
        GatewaySubnet = {
          name = "GatewaySubnet" #Must be called GateWaySubnet in order to host a Virtual Network Gateway
          cidr = ["100.64.0.0/27"] #100.64.0.0 - 100.64.0.31
        }
        AzureFirewallSubnet = {
          name = "AzureFirewallSubnet" #Must be called AzureFirewallSubnet
          cidr = ["100.64.0.32/27"]#100.64.0.32 - 100.64.0.63
        }
      }
      subnets = {
        jumpbox = {
          name    = "jumpbox"
          cidr    = ["100.64.1.0/24"]#100.64.1.0 - 100.64.1.255
          nsg_key = "jumpbox"
        }        
        private_endpoints = {
          name                                           = "private_endpoints"
          cidr                                           = ["100.64.0.64/27"] #100.64.0.64 - 100.64.0.95
          enforce_private_link_endpoint_network_policies = true
        }
      }
    }
  }
}