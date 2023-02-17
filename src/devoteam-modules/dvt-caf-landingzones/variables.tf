variable "landingzone" {}
variable "backend" {
  default = {}
}

variable "azurerm_client_id" {
  default = null
}

variable "azurerm_client_secret" {
  default = null
}

variable "tenant_id" {
  default = null
}

variable "subscription_id" {
  default = null
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