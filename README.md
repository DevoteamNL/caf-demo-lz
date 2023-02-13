# Budget Thuis Azure Landing Zone

## Intro

This repo contains the terraform code to implement an Azure Landing Zone to Budget Thuis. The modules are developmed using the Microsoft Cloud Adoption Framework for Azure. To get more details follow the link: https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/

This code is based on the terraform-azurerm-caf module: https://github.com/aztfmod/terraform-azurerm-caf


## Development Workspace requirements
 - Terraform
 - Visual Studio Code
 - Git Client


## The project structure
```
📦budget-thuis-lz
 ┣ 📂assets
 ┃ ┗ 📜architecture.jpeg
 ┣ 📂src
 ┃ ┣ 📂caf
 ┃ ┃ ┣ 📂core
 ┃ ┃ ┃ ┣ 📂connectivity
 ┃ ┃ ┃ ┃ ┣ 📜landingzone.tfvars
 ┃ ┃ ┃ ┃ ┗ 📜network_security.tfvars
 ┃ ┃ ┃ ┣ 📂identity
 ┃ ┃ ┃ ┃ ┗ 📜landingzone.tfvars
 ┃ ┃ ┃ ┗ 📂management
 ┃ ┃ ┃ ┃ ┗ 📜landingzone.tfvars
 ┃ ┃ ┣ 📂workload
 ┃ ┃ ┃ ┣ 📂nonprod
 ┃ ┃ ┃ ┃ ┗ 📜landingzone.tfvars
 ┃ ┃ ┃ ┣ 📂prod
 ┃ ┃ ┃ ┗ 📜landingzone.tfvars
 ┃ ┃ ┗ 📜global-settings.tfvars
 ┃ ┣ 📂dvt-caf
 ┃ ┃ ┣ 📂modules
 ┃ ┗ 📂dvt-caf-landingzone
 ┃ ┃ ┣ 📜connectivity_plan.ps1
 ┃ ┃ ┣ 📜landingzone.tf
 ┃ ┃ ┣ 📜local.remote.tf
 ┃ ┃ ┣ 📜locals.remote_tfstates.tf
 ┃ ┃ ┣ 📜main.tf
 ┃ ┃ ┗ 📜variables.tf
 ┣ 📜.gitignore
 ┗ 📜README.md
```
 - 📂[module_name] - The module folder contains the terraform configuration to an specific azure resources.
 - 📂[submodule_name] - The submodule folder contains the terraform configuration to an specific "sub-resource" like an subnet is part of a virtual network.
 - 📜[module_wrapper_name].tf - The module wrapper is to improve the code reuse and organize the creation of resources from a same type. 

## Architecture

![Devoteam CAF Terraform Module](assets/architecture.jpeg)

See details: [Lucid Chart](https://lucid.app/lucidchart/8214442d-934b-49cc-a34c-5924447475e0/edit?viewport_loc=-2324%2C-843%2C5450%2C2591%2C0_0&invitationId=inv_5c53211b-8739-42af-b48f-d0e178efcb95)

## Resources naming convention

The naming convention of this project is based on the Cloud Adoption Framework for Azure - Terraform module, using the "azurecaf_name" resource, to configure a standard naming convention across the landing zones. See the documentation [here](https://github.com/aztfmod/terraform-azurerm-caf/blob/main/documentation/conventions.md). 

## Setup the Landing Zone



### The "globalsettings.tfars" file

Global Settings. TO DO.


### The "landingzone.tfvars" file


This file has the settings, and the resources contained in the landing zone.

``` 
landingzone = {
  backend_type = "azurerm"
  key          = "connectivity"
}

environment = "production"

resource_groups = {
  hub-rg = {
    name     = "conn-hub-rg"
    location = "region1"

  }
}

```


### Global Configuration

The global_setting referenced in the Devoteam CAF Module is necessary to provide a set of standards to the landing zone resources, based on the Microsoft Cloud Adoption framework.




## Getting Started
 TO DO.



 



