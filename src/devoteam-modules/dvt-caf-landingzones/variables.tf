variable "landingzone" {}
variable "backend" {
  default = {}
}

variable "azurerm_client_id" {
  
}

variable "azurerm_client_secret" {
  
}

variable "tenant_id" {
  
}

variable "subscription_id" {
  
}
variable "resource_groups" {}
variable "subscriptions" {
    default = {}
}

variable "global_settings" {}



variable "storage_accounts" {
    default = {}
}


variable "networking" {
    default = {}
}


variable "compute" {
    default = {}
}


variable "tags" {
  default = {}
}