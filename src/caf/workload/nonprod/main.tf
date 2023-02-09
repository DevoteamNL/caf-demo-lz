  terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.45"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 1.4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 2.2.1"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 2.1.0"
    }
    external = {
      source  = "hashicorp/external"
      version = "~> 1.2.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.6.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 3.0.0"
    }
    azurecaf = {
      source  = "aztfmod/azurecaf"
      version = "~> 1.2.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.2"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.11.1"
    }
    flux = {
      source  = "fluxcd/flux"
      version = ">= 0.0.14"
    }
  }
  required_version = ">= 0.13"

  # comment it out for the local backend experience
  # backend "azurerm" {}

    /* backend "azurerm" {
        resource_group_name  = "tfstatenonprod"
        storage_account_name = "mmtfstatenonprod"
        container_name       = "tfstate-qa"
        key                  = "ayIfB1VSZt58MJwNhYErA3DDqm+qjY0vovl2gNmvql4q8CSvptlq1XvdZc//DR0IYo3HjezXrAj3+AStmZq71A=="
    } */

  }



provider "azurerm" {
  subscription_id = "e394467d-715c-4a8d-952a-76e393cacd0e"
  tenant_id = "b4c7cb7e-0d4d-4c4e-8d9c-d5aee201bd1c"
  client_id = "c5b40152-63c2-4a9c-8093-1a692b91dd97"
  client_secret = "68-8Q~baQtdOPqW1O9aXGTUytUw1c8OzFai5QbeT"  
  features {}
}

