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
variable "client_config" {default = {}}
variable "diagnostics" {default = {}}
variable "settings" {
    description = "Settings of the AKS Cluster"
    default = {
        default_node_pool: {
            name: "default"
        }
    }
}
