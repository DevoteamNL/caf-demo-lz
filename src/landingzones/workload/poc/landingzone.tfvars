landingzone = {
  backend_type = "azurerm"
  key          = "poc"
  tfstates = {
    current = {
      storage_account_name = "sttfstatedvtcaf"
      container_name       = "poc-vnet"
      resource_group_name  = "caf-tfstate-rg"
      tfstate              = "caf_poc-vnet.tfstate"

    }
  }
}

resource_groups = {
  hub-rg = {
    name     = "demo-network-hub-rg"
    location = "region1"
  }
  spoke-rg = {
    name     = "demo-network-spoke-rg"
    location = "region1"
  }
}

networking = {
  vnets = {
    hub = {
      resource_group_key = "hub-rg"
      region             = "region1"
      vnet = {
        name          = "spoke-vnet"
        address_space = ["10.1.0.0/16"]
      }
      specialsubnets = {}
      subnets = {
        default = {
          name    = "default"
          cidr    = ["10.1.1.0/24"]          
        }
      }
    }
    spoke = {
      resource_group_key = "spoke-rg"
      region             = "region1"
      vnet = {
        name          = "spoke-vnet"
        address_space = ["192.168.0.0/16"]
      }
      specialsubnets = {}
      subnets = {
        default = {
          name    = "default"
          cidr    = ["192.168.0.0/24"]          
        }
      }
    }
  }

  vnet_peerings = {
    spoke_To_Hub = {
        name = "spoke_To_Hub"
        to = {
            vnet_key = "hub"
        }
        from = {            
            vnet_key = "spoke"
        }
    }   
    hub_to_spoke = {
        name = "hub_to_spoke"
        from = {
            vnet_key = "hub"
        }
        to = {            
            vnet_key = "spoke"
        }
    }    
  }
}

network_security_group_definition = { 
  demo = {
    nsg = [
      {
        name                       = "ssh-inbound-22",
        priority                   = "200"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "VirtualNetwork"
      },
      {
        name                       = "http-inbound-80",
        priority                   = "210"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "VirtualNetwork"
      } 
      ]
  }
}


compute = {
  virtual_machines = {
      hub_vm = {
        resource_group_key = ""
        provision_vm_agent = ""
        os_type = "linux"
        virtual_machine_settings  = {
          linux = {
            name = ""
            size = ""
            admin_username = ""
            password = ""           
            identity = {
              type = "SystemAssigned"
            }
            source_image_reference = {

            }
          }
        }
        
      }

  }
}



