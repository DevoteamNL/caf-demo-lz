# Budget Thuis Azure Landing Zone

## Intro

This repo contains the terraform code to implement an Azure Landing Zone to Budget Thuis. The modules are developmed using the Microsoft Cloud Adoption Framework for Azure. To get more details follow the link: https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/


## Development Workspace requirements
 - Terraform
 - Visual Studio Code
 - Git Client


## Setup Azure Service Principal for local environment

To run the commands locally you will need to setup the sensitive variables using Environment variables, to setup it using Powershell, please use the following commands:

```powershell

$Env:TF_VAR_az_ad_sp_appId = "[SERVICE_PRINCIPAL_CLIENT_ID]"; 
$Env:TF_VAR_az_ad_sp_secret = "[SERVICE_PRINCIPAL_SECRET]";

```


## Project Structure

```
📦budget-thuis-lz
 ┣ 📂src
 ┃ ┗ 📂caf
 ┃ ┃ ┣ 📂core
 ┃ ┃ ┗ 📂workload
 ┃ ┃ ┃ ┣ 📂nonprod
 ┃ ┃ ┃ ┃ ┣ 📂compute
 ┃ ┃ ┃ ┃ ┃ ┗ 📜aks_clusters.tfvars
 ┃ ┃ ┃ ┃ ┣ 📂database
 ┃ ┃ ┃ ┃ ┃ ┣ 📜mssql_databases.tfvars
 ┃ ┃ ┃ ┃ ┃ ┗ 📜mssql_servers.tfvars
 ┃ ┃ ┃ ┃ ┣ 📂diagnostics
 ┃ ┃ ┃ ┃ ┃ ┗ 📜diagnostics.tfvars
 ┃ ┃ ┃ ┃ ┣ 📂networking
 ┃ ┃ ┃ ┃ ┃ ┗ 📜networking.tfvars
 ┃ ┃ ┃ ┃ ┣ 📂remotestate
 ┃ ┃ ┃ ┃ ┃ ┣ 📜main.tf
 ┃ ┃ ┃ ┃ ┣ 📂security
 ┃ ┃ ┃ ┃ ┃ ┣ 📜keyvaults.tfvars
 ┃ ┃ ┃ ┃ ┃ ┣ 📜managed_identities.tfvars
 ┃ ┃ ┃ ┃ ┃ ┗ 📜role_mapping.tfvars 
 ┃ ┃ ┃ ┃ ┣ 📜global.tfvars
 ┃ ┃ ┃ ┃ ┣ 📜main.tf
 ┃ ┃ ┃ ┃ ┣ 📜module.tf
 ┃ ┃ ┃ ┃ ┣ 📜plan.ps1
 ┃ ┃ ┃ ┃ ┗ 📜variables.tf
 ┃ ┃ ┃ ┗ 📂prod
 ┣ 📜.gitignore
 ┗ 📜README.md
```

The remote state is configured by subscription.

## Resources naming convention

Azure Cloud Adoption Framework - Terraform provider

This provider implements a set of methodologies for naming convention implementation including the default Microsoft Cloud Adoption Framework for Azure recommendations as per https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/naming-and-tagging.


The azurecaf_name resource allows you to:

 - Clean inputs to make sure they remain compliant with the allowed patterns for each Azure resource.
 - Generate random characters to append at the end of the resource name.
 - Handle prefix, suffixes (either manual or as per the Azure cloud adoption framework resource conventions).
 - Allow passthrough mode (simply validate the output).


## Usage


```terraform

module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "~> 5.4.0"
  global_settings      = merge((var.override_prefix == "" ? {} : { prefix = var.override_prefix }), var.global_settings)
  logged_user_objectId = "[logged_user_objectid]" 
  tags                 = var.tags
  resource_groups      = var.resource_groups
  keyvaults            = var.keyvaults
  managed_identities   = var.managed_identities
  role_mapping         = var.role_mapping 
  azuread = {
    azuread_groups  = var.azuread_groups
  }
  networking = {
    vnets = var.vnets
  }
}

```

The CAF module is a terraform module to deploy azure resources based on Microsoft Cloud Adoption Framewrork. This terraform module was used to deploy the landing zone. More deatails in: https://github.com/aztfmod/terraform-azurerm-caf





### Global Settings 

The Global Settings variable is present in all modules to padronize some configuration as Default Region, Tags, etc. Usage:

``` terraform

global_settings = {
    default_region = "region1"
    regions = {
      region1 = "westeurope"
    }
}

resource_groups = {
  aks_re1 = {
    name   = "aks-re1"
    region = "region1"
  }
}



```




