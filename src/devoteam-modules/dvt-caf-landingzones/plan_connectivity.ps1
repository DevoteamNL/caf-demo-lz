terraform init -backend-config "../../landingzones/core/connectivity/connectivity.tfbackend" 
terraform init -backend-config "../../landingzones/core/connectivity/connectivity.tfbackend"   -upgrade
terraform plan -var-file "../../landingzones/global-settings.tfvars" -var-file "../../landingzones/core/connectivity/landingzone.tfvars" 