terraform init --upgrade
terraform plan -var-file "../caf/remote/global.tfvars" -var-file "../caf/remote/storage.tfvars"