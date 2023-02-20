networking = {
  vnets = {
    // AKS SPOKE VNET
    spoke_re1 = {
      resource_group_key = "nonprod-rg"
      region             = "region1"
      vnet = {
        name          = "aks"
        address_space = ["100.64.48.0/22"]
      }
      specialsubnets = {}
      subnets = {
        aks_nodepool_system = {
          name    = "aks_nodepool_system"
          cidr    = ["100.64.48.0/24"]
          nsg_key = "azure_kubernetes_cluster_nsg"
        }
        private_endpoints = {
          name                                           = "private_endpoints"
          cidr                                           = ["100.64.51.0/27"]
          enforce_private_link_endpoint_network_policies = true
        }
        jumpbox = {
          name    = "jumpbox"
          cidr    = ["100.64.51.128/27"]
          nsg_key = "azure_bastion_nsg"
        }
      }
    }
  }
   vnet_peerings = {
    hub-re1_TO_spoke-re1 = {
      name = "hub-re1_TO_spoke-re1"
      from = {
        lz_key = "connectivity" 
        output_key = "vnets"
        vnet_key   = "hub_re1"
      }
      to = {
        vnet_key = "spoke_re1"
      }
      allow_virtual_network_access = true
      allow_forwarded_traffic      = true
      allow_gateway_transit        = false
      use_remote_gateways          = false
    }
    spoke-re1_TO_hub-re1 = {
      name = "hub_re2_TO_hub_re1"
      from = {
        vnet_key = "spoke_re1"
      }
      to = {
        lz_key = "connectivity" 
        output_key = "vnets"
        vnet_key   = "hub_re1"
      }
      allow_virtual_network_access = true
      allow_forwarded_traffic      = false
      allow_gateway_transit        = false
      use_remote_gateways          = false
    }
  }
} 
