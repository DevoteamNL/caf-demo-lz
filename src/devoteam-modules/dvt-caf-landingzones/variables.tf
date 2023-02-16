variable "landingzone" {}
variable "backend" {}
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