terraform init
terraform init -upgrade
terraform plan -var-file "../caf/global-settings.tfvars" -var-file "../caf/workload/nonprod/landingzone.tfvars" 
