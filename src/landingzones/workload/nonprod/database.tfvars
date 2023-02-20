database = {
  mssql_servers = {
    mssqlserver1 = {
      name                          = "nonprod-mssqlserver"
      region                        = "region1"
      resource_group_key            = "nonprod-rg"
      version                       = "12.0"
      administrator_login           = "sqluseradmin"
      keyvault_key                  = "kv1"
      connection_policy             = "Default"
      public_network_access_enabled = true
      identity = {
        type = "SystemAssigned"
      }
    }
  }

  mssql_databases = {
    mssql_db1 = {
      name               = "exampledb1"
      resource_group_key = "nonprod-rg"
      mssql_server_key   = "mssqlserver1"
      license_type       = "LicenseIncluded"
      max_size_gb        = 4
      sku_name           = "BC_Gen5_2"

      db_permissions = {
        group1 = {
          db_roles = ["db_owner", "db_accessadmin"]
          managed_identities = {
            nonprod = {
              managed_identity_keys = ["webapp_mi"]
            }
          }
        }
      }
    }
  }
}
