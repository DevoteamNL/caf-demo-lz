variable "name" {
   description = "Name of the KeyVault resource"
}

variable "location" {}

variable "resource_group_name" {}

variable "client_config" {}

variable "settings" {}

variable "vnets" {
  default = {}
}
variable "azuread_groups" {
  default = {}
}
variable "managed_identities" {
  default = {}
}
# For diagnostics settings
variable "diagnostics" {
  default = {}
}

variable "private_dns" {
  default = {}
}