landingzone = {
  backend_type = "azurerm"
  key = "nonprod"
  tfstates = {
    current = {
      storage_account_name = "uzexstnonprodaqcu"
      container_name       = "tfstate"
      resource_group_name  = "uzex-rg-caf-nonpror-dhvk"
      key                  = "caf_nonprod.tfsate"
      tenant_id            = "95f1c0e9-c50b-4882-87de-bb2470f0d5ad"
      subscription_id      = "c1cbea85-2d1c-4f36-a6d7-636df95de7e0"
      client_id       = "e6c0bbdc-82d2-4fbf-9dec-35e3cd4b2e24"
      client_secret   = "ur_8Q~g7yiq7u4iLSshsBcza8UK9loiHQzXolcxn"      
    }
    lower = {
      storage_account_name = "uzexstconnctivityeoui"
      container_name       = "tfstate"
      resource_group_name  = "uzex-rg-caf-connectivity-syhw"
      key                  = "caf_connectivity.tfsate"
      tenant_id            = "95f1c0e9-c50b-4882-87de-bb2470f0d5ad"
      subscription_id      = "c1cbea85-2d1c-4f36-a6d7-636df95de7e0"
      client_id       = "e6c0bbdc-82d2-4fbf-9dec-35e3cd4b2e24"
      client_secret   = "ur_8Q~g7yiq7u4iLSshsBcza8UK9loiHQzXolcxn"      
    }
  }
}


remote_state = {
  storage_account_name = "lzremotestate"
  container_name       = "landingzones"
  resource_group_name  = "caf-remote-states"
  tfstate_key          = "nonprod"
  tenant_id            = "95f1c0e9-c50b-4882-87de-bb2470f0d5ad"
  subscription_id      = "c1cbea85-2d1c-4f36-a6d7-636df95de7e0"

}


backend = {
  tenant_id       = "95f1c0e9-c50b-4882-87de-bb2470f0d5ad"
  subscription_id = "c1cbea85-2d1c-4f36-a6d7-636df95de7e0"
  client_id       = "e6c0bbdc-82d2-4fbf-9dec-35e3cd4b2e24"
  client_secret   = "ur_8Q~g7yiq7u4iLSshsBcza8UK9loiHQzXolcxn"
}


resource_groups = {
  nonprod-rg = {
    name     = "app-nonprod-rg"
    location = "region1"

  }
}

storage_accounts = {
  
  app_nonprod = {
    name                      = "l0"
    resource_group_key        = "nonprod-rg"
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
  vnets = {
    // AKS SPOKE VNET
    spoke_aks_re1 = {
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
        aks_nodepool_user1 = {
          name    = "aks_nodepool_user1"
          cidr    = ["100.64.49.0/24"]
          nsg_key = "azure_kubernetes_cluster_nsg"
        }
        aks_nodepool_user2 = {
          name    = "aks_nodepool_user2"
          cidr    = ["100.64.50.0/24"]
          nsg_key = "azure_kubernetes_cluster_nsg"
        }
        AzureBastionSubnet = {
          name    = "AzureBastionSubnet"
          cidr    = ["100.64.51.64/27"]
          nsg_key = "azure_bastion_nsg"
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
}

compute = {
 
  azure_container_registries = {
    acr1 = {
      name               = "lz-nonprod-acr"
      resource_group_key = "nonprod-rg"
      sku                = "Premium"
      #public_network_access_enabled = "false" #Only able to control when sku = "premium"
    }
  }

  aks_clusters = {
    aks_nonprod = {
      name               = "akscluster-re1-001"
      resource_group_key = "nonprod-rg"
      os_type            = "Linux"
      identity = {
        type = "SystemAssigned"
      }
      vnet_key = "spoke_aks_re1"
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
          #resource_id = "/subscriptions/97958dac-xxxx-xxxx-xxxx-9f436fa73bd4/resourceGroups/qxgc-rg-aks-re1/providers/Microsoft.Network/virtualNetworks/qxgc-vnet-aks/subnets/qxgc-snet-aks_nodepool_system"
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
