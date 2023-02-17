landingzone = {
  backend_type = "azurerm"
  key          = "connectivity"
  environment  = "production"
  tfstates = {
    current = {      
      storage_account_name = "sttfstatebudgetthuis"
      container_name       = "connectivity"
      resource_group_name  = "caf-bt-tfstate-rg"
      key                  = "caf_connectivity.tfsate"
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


