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
 ┃ ┣ 📂core
 ┃ ┃ ┣ 📂connectivity
 ┃ ┃ ┣ 📂identity
 ┃ ┃ ┗ 📂management
 ┃ ┣ 📂modules
 ┃ ┃ ┣ 📂aks
 ┃ ┃ ┃ ┣ 📜main.tf
 ┃ ┃ ┣ 📂managed-identity
 ┃ ┃ ┃ ┣ 📜main.tf
 ┃ ┃ ┣ 📂networking
 ┃ ┃ ┃ ┣ 📂dns
 ┃ ┃ ┃ ┗ 📂virtual_network
 ┃ ┃ ┃ ┃ ┣ 📂subnet
 ┃ ┃ ┃ ┃ ┃ ┣ 📜main.tf
 ┃ ┃ ┃ ┃ ┣ 📜main.tf
 ┃ ┃ ┣ 📂security
 ┃ ┃ ┃ ┣ 📂keyvault
 ┃ ┃ ┃ ┃ ┣ 📜main.tf
 ┃ ┃ ┃ ┗ 📂keyvault_key
 ┃ ┃ ┃ ┃ ┣ 📜main.tf
 ┃ ┃ ┣ 📂sql-db
 ┃ ┃ ┗ 📂sql-server
 ┃ ┗ 📂non_prod
 ┃ ┃ ┣ 📂remote-state
 ┃ ┃ ┃ ┣ 📜main.tf
 ┃ ┃ ┣ 📜main.tf
 ┃ ┃ ┣ 📜README.md
 ┣ 📜.gitignore
 ┗ 📜README.md
```

The remote state is configured by subscription.

## Resources naming convention

| Resource Type| Composition | Example    | Obs. |
|--------------|-------------|------------|------|
| Resource Group| rg-[app or service name]-[subscription purpose]-[###] | rg-tfstate-prod-001| N/A|



## AKS

### Azure AD Workload Identity

Workloads deployed in Kubernetes clusters require Azure AD application credentials or managed identities to access Azure AD protected resources, such as Azure Key Vault and Microsoft Graph. The Azure AD Pod Identity open-source project provided a way to avoid needing these secrets, by using Azure managed identities.

Azure AD Workload Identity for Kubernetes integrates with the capabilities native to Kubernetes to federate with external identity providers.

In this model, the Kubernetes cluster becomes a token issuer, issuing tokens to Kubernetes Service Accounts. These service account tokens can be configured to be trusted on Azure AD applications or user-assigned managed identities. Workload can exchange a service account token projected to its volume for an Azure AD access token using the Azure Identity SDKs or the Microsoft Authentication Library (MSAL).

More details: https://azure.github.io/azure-workload-identity/docs/introduction.html


#### Workload Identity Usage

- Kubernetes Service Account
- Managed Identities or Azure AD application

