//===================================// 
//AUTHENTICATION AZURE RM PROVIDER ==//
//===================================//

variable "client_id" {}
variable "client_secret" {}
variable "subscription_id" {}
variable "tenant_id" {}

//===================================//
//===================================//
//===================================//

variable "global_settings" {}
variable "resource_groups" {default = {}}
variable "keyvaults" {default = {}}
variable "azure_container_registries" {default = {}}
variable "aks_clusters" {default = {}}
variable "vnets" {default = {}}


