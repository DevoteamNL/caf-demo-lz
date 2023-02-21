terraform init -backend-config "../../landingzones/workload/nonprod/nonprod.tfbackend"
terraform init -backend-config "../../landingzones/workload/nonprod/nonprod.tfbackend" -upgrade
terraform plan -var-file "../../landingzones/global-settings.tfvars" -var-file "../../landingzones/workload/nonprod/landingzone.tfvars"   
