

managed_identities = {
  webapp_mi = {
    name               = "example_db_mi"
    resource_group_key = "nonprod-rg"
  }
}



keyvaults = {
  kv1 = {
    name               = "nonprodkv"
    resource_group_key = "nonprod-rg"
    sku_name           = "standard"
    creation_policies = {
      logged_in_user = {
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge"]
      }
    }
  }
}
