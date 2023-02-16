terraform init --upgrade
terraform plan -var-file "../../landingzones/remote/global.tfvars" -var-file "../../landingzones/remote/storage.tfvars"