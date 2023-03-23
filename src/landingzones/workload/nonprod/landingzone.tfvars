landingzone = {
  backend_type = "azurerm"
  key          = "nonprod"
  tfstates = {
    current = {
      storage_account_name = "sttfstatedvtcaf"
      container_name       = "nonprod"
      resource_group_name  = "caf-tfstate-rg"
      tfstate              = "caf_nonprod.tfstate"

    }
    connectivity = {
      storage_account_name = "sttfstatedvtcaf"
      container_name       = "connectivity"
      resource_group_name  = "caf-tfstate-rg"
      tfstate              = "caf_connectivity.tfstate"

    }
  }
}

resource_groups = {
  nonprod-rg = {
    name     = "app-nonprod-rg"
    location = "region1"
  }
}

managed_identities = {
  nonprodapp_mi = {
    name               = "dvt_db_mi"
    resource_group_key = "nonprod-rg"
  }
}

networking = {
  vnets = {
    spoke_re1 = {
      resource_group_key = "nonprod-rg"
      region             = "region1"
      vnet = {
        name          = "aks"
        address_space = ["10.1.0.0/16"]
      }
      specialsubnets = {}
      subnets = {
        aks_nodepool_system = {
          name    = "aks_nodepool_system"
          cidr    = ["10.1.1.0/24"]
          nsg_key = "azure_kubernetes_cluster_nsg"
        }
        private_endpoints = {
          name                                           = "private_endpoints"
          cidr                                           = ["10.1.16.0/27"]
          enforce_private_link_endpoint_network_policies = true
        }
      }
    }
  }
  vnet_peerings = {
    spoke_to_hub = {
      from = {
        vnet_key = "spoke_re1"
      }
      to = {
        lz_key   = "connectivity"
        vnet_key = "hub_vnet"
      }
      allow_virtual_network_access = true
      allow_forwarded_traffic      = true
    }
  }
}

compute = {
  azure_container_registries = {
    acr1 = {
      name               = "dvtnonprodacr"
      resource_group_key = "nonprod-rg"
      sku                = "Premium"
    }
  }

  aks_clusters = {
    aks_nonprod = {
      name               = "akscluster-re1"
      resource_group_key = "nonprod-rg"
      os_type            = "Linux"
      identity = {
        type                 = "UserAssigned"
        managed_identity_key = "nonprodapp_mi"
      }
      vnet_key = "spoke_re1"
      network_profile = {
        network_plugin    = "azure"
        load_balancer_sku = "Standard"
      }
      # enable_rbac = true      
      role_based_access_control = {
        enabled = true
        azure_active_directory = {
          managed = true
        }
      }

      addon_profile = {
        oms_agent = {
          enabled           = false
          log_analytics_key = "central_logs_region1"
        }
      }
      load_balancer_profile = {
        managed_outbound_ip_count = 1
      }

      default_node_pool = {
        name       = "sharedsvc"
        vm_size    = "Standard_F4s_v2"
        subnet_key = "aks_nodepool_system"
        subnet = {
          key = "aks_nodepool_system"
        }
        enabled_auto_scaling  = false
        enable_node_public_ip = false
        max_pods              = 30
        node_count            = 1
        os_disk_size_gb       = 512
        tags = {
          "project" = "Non Prod Test Node Pool"
        }
      }
      node_resource_group_name = "app-nonprod-nodes-rg"

      addon_profile = {
        azure_keyvault_secrets_provider = {
          secret_rotation_enabled  = true
          secret_rotation_interval = "2m"
        }
      }
    }
  }
}
