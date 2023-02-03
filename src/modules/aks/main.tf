resource "azurerm_kubernetes_cluster" "aks" {  
  name                              = var.name
  location                          = var.location
  resource_group_name               = var.resource_group_name
  dns_prefix                        = var.dns_prefix
  role_based_access_control { 
    enabled = try(var.role_based_access_control_enabled, true)
  }
  

  default_node_pool {
    availability_zones           = try(var.settings.default_node_pool.availability_zones, null)
    enable_auto_scaling          = try(var.settings.default_node_pool.enable_auto_scaling, false)
    enable_host_encryption       = try(var.settings.default_node_pool.enable_host_encryption, false)
    enable_node_public_ip        = try(var.settings.default_node_pool.enable_node_public_ip, false)        
    max_count                    = try(var.settings.default_node_pool.max_count, null)
    max_pods                     = try(var.settings.default_node_pool.max_pods, 30)
    min_count                    = try(var.settings.default_node_pool.min_count, null)
    name                         = var.settings.default_node_pool.name 
    node_count                   = try(var.settings.default_node_pool.node_count, 1)
    node_labels                  = try(var.settings.default_node_pool.node_labels, null)    
    orchestrator_version         = try(var.settings.default_node_pool.orchestrator_version, try(var.settings.kubernetes_version, null))
    os_disk_size_gb              = try(var.settings.default_node_pool.os_disk_size_gb, null)
    os_disk_type                 = try(var.settings.default_node_pool.os_disk_type, null)    
    tags                         = try(var.settings.default_node_pool.tags, {})
    type                         = try(var.settings.default_node_pool.type, "VirtualMachineScaleSets")
    vm_size                      = var.settings.default_node_pool.vm_size
    vnet_subnet_id               = null
  }


  linux_profile {
    admin_username = var.settings.linux_profile.admin_username
    ssh_key {
      key_data = var.settings.linux_profile.ssh_public_key
    }
  }

}