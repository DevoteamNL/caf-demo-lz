#== AUTHENTICATION AZURE RM PROVIDER ==#

variable "client_id" {
  sensitive = true
}

variable "client_secret" {
  sensitive = true
}

variable "subscription_id" {
  sensitive = true
}

variable "tenant_id" {
  sensitive = true
}

#======================================#


variable "global_settings" {
}

variable "resource_groups" {
  default = {}
}

variable "keyvaults" {
  default = {}
}

variable "azure_container_registries" {
 default = {}  
}


variable "aks_clusters" {
 default = {}  
}


variable "vnets" {
 default = {}  
}


