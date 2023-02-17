terraform init --upgrade
terraform validate 
terraform plan -var-file "../../landingzones/global-settings.tfvars" -var-file "../../landingzones/remote/launch_remote.tfvars"
#terraform apply -var-file "../../landingzones/global-settings.tfvars" -var-file "../../landingzones/remote/launch_remote.tfvars"