terraform init
terraform init -upgrade
terraform plan -var-file "../../landingzones/global-settings.tfvars" -var-file "../../landingzones/workload/nonprod/landingzone.tfvars" 
