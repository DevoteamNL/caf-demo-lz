terraform init -backend-config "../../landingzones/workload/nonprod/nonprod.tfbackend"
terraform init -backend-config "../../landingzones/workload/nonprod/nonprod.tfbackend" -upgrade
terraform plan -var-file "../../landingzones/global-settings.tfvars" -var-file "../../landingzones/workload/nonprod/landingzone.tfvars"   -var 'logged_aad_app_objectId=41df896d-c214-46ed-aeb8-de3754779e7b' -var 'logged_user_objectId=d54698ea-47fd-4fd1-9968-59bff3310080'
