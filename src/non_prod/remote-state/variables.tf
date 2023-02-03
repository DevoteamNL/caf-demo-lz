variable "az_ad_sp_appId" {
    type = string    
    description = "The Azure Active Directory Service Principal Client Id"  
    sensitive = true
}


variable "az_ad_sp_secret" {
    type = string    
    description = "The Azure Active Directory Service Principal Client Secret"  
    sensitive = true
}

