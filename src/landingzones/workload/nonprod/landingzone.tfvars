landingzone = {
  backend_type = "azurerm"
  key          = "nonprod"
  tfstates = {
    current = {
      storage_account_name = "sttfstatebudgetthuis"
      container_name       = "nonprod"
      resource_group_name  = "caf-bt-tfstate-rg"
      tfstate              = "caf_nonprod.tfsate"
    }
    connectivity = {
      storage_account_name = "sttfstatebudgetthuis"
      container_name       = "connectivity"
      resource_group_name  = "caf-bt-tfstate-rg"
      tfstate              = "caf_connectivity.tfsate"
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
  webapp_mi = {
    name               = "example_db_mi"
    resource_group_key = "nonprod-rg"
  }
}

keyvaults = {
  kv1 = {
    name               = "nonprodkeyvault"
    resource_group_key = "nonprod-rg"
    sku_name           = "standard"
    creation_policies = {
      logged_in_aad_app = {
        secret_permissions = ["Set", "Get", "List", "Delete" ]
      }
      managed_identity = {
        managed_identity_key = "webapp_mi"
        secret_permissions   = ["Set", "Get", "List", "Delete", "Purge"]
      }
    }
  }
}

database = {
  mssql_servers = {
    mssqlserver1 = {
      name                          = "nonprod-mssqlserver"
      region                        = "region1"
      resource_group_key            = "nonprod-rg"
      version                       = "12.0"
      administrator_login           = "sqluseradmin"
      keyvault_key                  = "kv1"
      connection_policy             = "Default"
      public_network_access_enabled = true
      identity = {
        type = "SystemAssigned"
      }
    }
  }

  mssql_databases = {
    mssql_db1 = {
      name               = "exampledb1"
      resource_group_key = "nonprod-rg"
      mssql_server_key   = "mssqlserver1"
      license_type       = "LicenseIncluded"
      max_size_gb        = 4
      sku_name           = "BC_Gen5_2"

    }
  }
}

networking = {
  vnets = {
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
        lz_key     = "connectivity"
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
        lz_key     = "connectivity"
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

compute = {
  azure_container_registries = {
    acr1 = {
      name               = "lz-nonprod-acr"
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
        managed_identity_key = "webapp_mi"
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
          "project" = "Non Prod Test Application"
        }
      }
      node_resource_group_name = "nonprod-rg"

      addon_profile = {
        azure_keyvault_secrets_provider = {
          secret_rotation_enabled  = true
          secret_rotation_interval = "2m"
        }
      }
    }
  }
}




