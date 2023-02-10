# GLOBAL SETTINGS
global_settings = {
  random_length  = 0
  default_region = "region1"
  passthrough = true
  regions = {
    region1 = "westeurope"
    region2 = "northeurope"
  }
}

# RESOURCE GROUPS
resource_groups = {
  rg-lz-nonprod = {
    name   = "dvt-lz-nonprod"
    region = "region1"
  }
}




# NETWORKING

vnets = {
  // AKS SPOKE VNET
  spoke_aks_re1 = {
    resource_group_key = "rg-lz-nonprod"
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

network_security_group_definition = {
  # This entry is applied to all subnets with no NSG defined
  empty_nsg = {}
  azure_kubernetes_cluster_nsg = {
    nsg = [
      {
        name                       = "aks-http-in-allow",
        priority                   = "100"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      {
        name                       = "aks-https-in-allow",
        priority                   = "110"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      {
        name                       = "aks-api-out-allow-1194",
        priority                   = "100"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "udp"
        source_port_range          = "*"
        destination_port_range     = "1194"
        source_address_prefix      = "*"
        destination_address_prefix = "AzureCloud"
      },
      {
        name                       = "aks-api-out-allow-9000",
        priority                   = "110"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "9000"
        source_address_prefix      = "*"
        destination_address_prefix = "AzureCloud"
      },
      {
        name                       = "aks-ntp-out-allow",
        priority                   = "120"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "udp"
        source_port_range          = "*"
        destination_port_range     = "123"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      {
        name                       = "aks-https-out-allow-443",
        priority                   = "130"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
    ]
  }
  azure_bastion_nsg = {
    nsg = [
      {
        name                       = "bastion-in-allow",
        priority                   = "100"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      {
        name                       = "bastion-control-in-allow-443",
        priority                   = "120"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "135"
        source_address_prefix      = "GatewayManager"
        destination_address_prefix = "*"
      },
      {
        name                       = "Kerberos-password-change",
        priority                   = "121"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "4443"
        source_address_prefix      = "GatewayManager"
        destination_address_prefix = "*"
      },
      {
        name                       = "bastion-vnet-out-allow-22",
        priority                   = "103"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "VirtualNetwork"
      },
      {
        name                       = "bastion-vnet-out-allow-3389",
        priority                   = "101"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "3389"
        source_address_prefix      = "*"
        destination_address_prefix = "VirtualNetwork"
      },
      {
        name                       = "bastion-azure-out-allow",
        priority                   = "120"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "AzureCloud"
      }
    ]
  } 
}

# KEY VAULT
keyvaults = {
  nonprodkv01 = {
    name               = "secrets"
    resource_group_key = "rg-lz-nonprod"
    sku_name           = "standard"
    creation_policies = {
      logged_in_user = {
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge"]
      }
    }
  }
}

keyvault_keys = {
  
  //SQL ADMIN PASS KEYVAULT KEY
  sql_admin_kv_key = {

  }

}

# CONTAINER 
azure_container_registries = {
  acr1 = {
    name               = "lz-nonprod-acr"
    resource_group_key = "rg-lz-nonprod"
    sku                = "Premium"
    #public_network_access_enabled = "false" #Only able to control when sku = "premium"
  }
}



# COMPUTE

## AKS
aks_clusters = {
  aks_nonprod = {
    name               = "akscluster-re1-001"
    resource_group_key = "rg-lz-nonprod"
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
      name    = "sharedsvc"
      vm_size = "Standard_F4s_v2"
      subnet_key            = "aks_nodepool_system"
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
    node_resource_group_name = "rg-lz-nonprod"
    addon_profile = {
      azure_keyvault_secrets_provider = {
        secret_rotation_enabled  = true
        secret_rotation_interval = "2m"
      }
    }
  }
}



# DATABASE

## MSSQL
mssql_servers = {
  mssql01 = {
    name                = "sql-rg1"
    region              = "region1"
    resource_group_key  = "rg_main_group"
    administrator_login = "sqladmin"
    keyvault_key        = "sql_rg1"
  }

}

mssql_databases = {
  name               = "exampledb1"
  resource_group_key = "rg1"
  mssql_server_key   = "mssqlserver1"
  license_type       = "LicenseIncluded"
  max_size_gb        = 4
  sku_name           = "BC_Gen5_2"
}
