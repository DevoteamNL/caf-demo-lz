landingzone = {
  backend_type = "azurerm"
  key = "nonprod"
  tfstates = {
    current = {
      storage_account_name = "sttfstatebudgetthuis"
      container_name       = "nonprod"
      resource_group_name  = "caf-bt-tfstate-rg"
      tfstate               = "caf_nonprod.tfsate"        
    }
    connectivity = {      
      storage_account_name = "sttfstatebudgetthuis"
      container_name       = "connectivity"
      resource_group_name  = "caf-bt-tfstate-rg"
      tfstate               = "caf_connectivity.tfsate"
    }
  }
}
  
resource_groups = {
  nonprod-rg = {
    name     = "app-nonprod-rg"
    location = "region1"
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
        type = "SystemAssigned"
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




