variable "landingzone" {
  description = "(Required)The Landing Zone Configuration."
}

variable "backend" {
  description = "(Optional)Backend configuration."
  default     = {}
}


variable "logged_user_objectId" {}

variable "logged_aad_app_objectId" {}

variable "azurerm_client_id" {
  description = "(Optional)Backend configuration."
  default     = null
}

variable "azurerm_client_secret" {
  description = "(Optional)Backend configuration."
  default     = null
}

variable "tenant_id" {
  description = "(Optional)Backend configuration."
  default     = null
}

variable "subscription_id" {
  description = "(Optional)Backend configuration."
  default     = null
}
variable "resource_groups" {
  description = "(Required)Resource Groups of the Landing Zone."
}

variable "subscriptions" {
  description = "(Optional)Azure Subscriptions to be created."
  default     = {}
}

variable "global_settings" {
  description = "(Required)The Global Settings. See the README."
}

variable "storage_accounts" {
  description = "(Optional)Storage accounts of the Landing Zone."
  default     = {}
}

variable "networking" {
  description = "(Optional)Backend configuration."
  default     = {}
}

variable "compute" {
  description = "(Optional)Compute resources (AKS, Virtual Machine, etc)."
  default     = {}
}

variable "database" {
  description = "(Optional)Database resources."
  default     = {}
}

variable "tags" {
  description = "(Optional)Tags."
  default     = {}
}

variable "keyvaults" {
  description = "(Optional)Keyvault resources."
  default     = {}
}


variable "managed_identities" {
  description = "(Optional)Managed Identities resources."
  default     = {}
}

variable "remote_state_access_key" {
  description = "(Optional) Set the remote state access key."
  default     = null
}

variable "keyvault_access_policies" {
  default = {}
}
