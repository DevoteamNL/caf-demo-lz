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
}




