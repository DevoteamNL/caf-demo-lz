# Global configuration
variable "global_settings" {
  description = "Global settings object (see module README.md)"
}

# Base configuration of the cluster
variable "name" {
    description = "The AKS cluster name."
}

variable "location" {
    description = "The resource location."    
}

variable "resource_group_name" {

}

variable "role_based_access_control_enabled" {
  description = "Enable Role Based Access control"
  default = true
}

# Dynamic configuration of the cluster (Complex objects)
variable "client_config" {}
variable "diagnostics" {}
variable "settings" {
    description = "Settings of the AKS Cluster"
    default = {
        default_node_pool: {
            name: "default"
        }
    }
}
variable "vnets" {}
variable "admin_group_object_ids" {}

variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
}

variable "diagnostic_profiles" {
  default = {}
}
variable "private_dns_zone_id" {
  default = null
}
variable "managed_identities" {
  default = {}
}
variable "application_gateway" {
  default = {}
}
