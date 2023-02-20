mssql_servers = {
  mssqlserver1 = {
    name                = "nonprod-mssqlserver"
    region              = "region1"
    resource_group_key  = "rg1"
    version             = "12.0"
    administrator_login = "sqluseradmin"
    keyvault_key        = "kv1"
    connection_policy   = "Default"
    public_network_access_enabled = true
    azuread_administrator = {
      azuread_group_key = "sqlserver_admin"
    }
    identity = {
      type = "SystemAssigned"
    }
  }
}

mssql_databases = {

  mssql_db1 = {
    name               = "exampledb1"
    resource_group_key = "rg1"
    mssql_server_key   = "mssqlserver1"
    license_type       = "LicenseIncluded"
    max_size_gb        = 4
    sku_name           = "BC_Gen5_2"

    # Only works with SystemAssigned MSI, logged_in users will not be able to provision the db_permission for now.
    db_permissions = {
      group1 = { # group_name
        db_roles = ["db_owner", "db_accessadmin"]
        managed_identities = {
          examples = {
            managed_identity_keys = ["webapp_mi"]
          }
        }
      }
    }

  }
}