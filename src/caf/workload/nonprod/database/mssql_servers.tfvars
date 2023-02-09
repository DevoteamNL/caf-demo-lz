azuread_groups = {
  sqlserver_admin = {
    name        = "example-sqlserver-admins"
    description = "Administrators of the sales SQL server."
    members = {
      user_principal_names = []

      # NOTE: To ensure DB users can be created, sqlserver admin needs to add the rover agent's system assigned identity object ID added
      # NOTE: since the authentication uses SQLCMD + DSN, UID cannot be supplied to the connection string, thus only system assigned identity is possible at this stage.
      object_ids = [
        # Add object id of rover agent with system assigned identity here.
      ]
      group_keys             = []
      service_principal_keys = []
    }
    owners = {
      user_principal_names = [
      ]
      service_principal_keys = []
      object_ids             = []
    }
    prevent_duplicate_name = false
  }
}


mssql_servers = {
  mssqlserver1 = {
    name                = "example-mssqlserver"
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



azuread_roles = {
  mssql_servers = {
    mssqlserver1 = {
      roles = ["Directory Readers"]
    }
  }
}