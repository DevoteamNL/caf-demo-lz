variable global_settings {}

variable "resource_groups" {
  description = "The necessary resource groups to the launcher setup."
}

variable "storage_accounts" {
  description = "The necessary storage accounts to store the terraform state files."
}

variable "launcher" {
  description = "The launcher configuration. See the README.md."
}


variable "azurerm_client_id" {}

variable "azurerm_client_secret" {}

variable "tenant_id" {}

variable "subscription_id" {}



#*******************************************#
#*******The Launcher remote state info******#
#*******************************************#

variable "tfstate_storage_account_name" {
  default = null
}
variable "tfstate_container_name" {
  default = null
}
variable "tfstate_key" {
  default = null
}
variable "tfstate_resource_group_name" {
  default = null
}



variable "sas_token" {
  description = "SAS Token to access the remote state in another Azure AD tenant."
  default     = null
}

variable "tf_name" {
  description = "Name of the terraform state in the blob storage (Does not include the extension .tfstate). Setup by the rover. Leave empty in the configuration file"
  default     = ""
}

