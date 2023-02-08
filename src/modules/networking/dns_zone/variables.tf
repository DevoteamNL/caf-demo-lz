variable "resource_group_name" {
  description = "(Required) The name of the resource group where to create the resource."
  type        = string
}

variable "client_config" {}

variable "settings" {}

variable "resource_ids" {
  default = {}
}