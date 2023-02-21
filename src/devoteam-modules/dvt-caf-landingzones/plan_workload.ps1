terraform init -backend-config "../../landingzones/workload/nonprod/nonprod.tfbackend"
terraform init -backend-config "../../landingzones/workload/nonprod/nonprod.tfbackend" -upgrade
terraform plan -var-file "../../landingzones/global-settings.tfvars" -var-file "../../landingzones/workload/nonprod/landingzone.tfvars"  -var-file "../../landingzones/workload/nonprod/azuread.tfvars" -var-file "../../landingzones/workload/nonprod/security.tfvars" -var-file "../../landingzones/workload/nonprod/networking.tfvars"  -var-file "../../landingzones/workload/nonprod/database.tfvars" 
