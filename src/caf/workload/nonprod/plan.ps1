#terraform plan -var-file=".\compute\aks_clusters.tfvars"  -var-file="global.tfvars"   -var-file="keyvaults.tfvars"   -var-file="managed_identities.tfvars"   -var-file="networking.tfvars"   -var-file="mssql_servers.tfvars"   -var-file="mssql_databases.tfvars" 


$files = ".\compute\aks_clusters.tfvars", "global.tfvars", ".\security\keyvaults.tfvars", ".\security\managed_identities.tfvars", ".\database\mssql_servers.tfvars",".\database\mssql_databases.tfvars",".\networking\networking.tfvars"

& terraform plan $files.ForEach({ '-var-file', $_ }) 