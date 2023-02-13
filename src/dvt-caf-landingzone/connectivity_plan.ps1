terraform init -upgrade
terraform plan -var-file "../caf/global-settings.tfvars" -var-file "../caf/core/connectivity/landingzone.tfvars" -var-file "../caf/core/connectivity/network_security.tfvars"