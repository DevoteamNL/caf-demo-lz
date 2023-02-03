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
$Env:TF_VAR_az_ad_tenantId = "[BUDGET_THUIS_TENANT_ID]";
$Env:TF_VAR_az_subscriptionId_non_prod = "[NON_PROD_SUBSCRIPTIONID]";
$Env:TF_VAR_az_ad_sp_appId = "[SERVICE_PRINCIPAL_CLIENT_ID]";
$Env:TF_VAR_az_ad_sp_secret = "[SERVICE_PRINCIPAL_SECRET]";
```


## Project Structure

```
📦budget-thuis-lz 
 ┣ 📂src
 ┃ ┣ 📂core
 ┃ ┃ ┣ 📂connectivity
 ┃ ┃ ┣ 📂identity
 ┃ ┃ ┗ 📂management
 ┃ ┣ 📂modules
 ┃ ┃ ┣ 📂aks
 ┃ ┃ ┣ 📂keyvault
 ┃ ┃ ┣ 📂managed-identity
 ┃ ┃ ┣ 📂network
 ┃ ┃ ┣ 📂sql-db
 ┃ ┃ ┗ 📂sql-server
 ┃ ┗ 📂non_prod
 ┣ 📜.gitignore
 ┗ 📜README.md
```

