global_settings = {       
    random_length  = 4
    default_region = "region1"      
    regions = {
      region1 = "westeurope"
      region2 = "northeurope"
    }
}


resource_groups = {
    rg_main_group = {
        name = "rafaelteste1"
    }
}


keyvaults = {
    nonprodkv01 = {
        name               = "secrets"
        resource_group_key = "kv_region1"
        sku_name           = "standard"
    }
}