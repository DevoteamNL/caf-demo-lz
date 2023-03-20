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

/* 
networking = {
  vnets = {
    hub_vnet = {
      resource_group_key = "hub-rg"
      region             = "region1"
      vnet = {
        name          = "mm-vnet-hub"
        address_space = ["10.0.0.0/16"]#10.0.0.0 - 10.0.255.255 
      }
      specialsubnets = {
        GatewaySubnet = {
          name = "GatewaySubnet" #Must be called GateWaySubnet in order to host a Virtual Network Gateway
          cidr = ["10.0.1.0/27"] #10.0.1.0 - 10.0.1.255
        }
        AzureFirewallSubnet = {
          name = "AzureFirewallSubnet" #Must be called AzureFirewallSubnet
          cidr = ["10.0.2.0/24"]#10.0.2.0 - 10.0.2.255
        }
      }
      subnets = {
        jumpbox = {
          name    = "jumpbox"
          cidr    = ["10.0.3.0/24"]#10.0.3.0 - 10.0.3.255
          nsg_key = "jumpbox"
        }        
        private_endpoints = {
          name                                           = "private_endpoints"
          cidr                                           = ["10.0.4.0/24"] #10.0.4.0 - 10.0.4.255
          enforce_private_link_endpoint_network_policies = true
        }
      }
    }
  }
} */