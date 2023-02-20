azuread_groups = {
  sqlserver_admin = {
    name        = "caf-sqlserver-admins"
    description = "Administrators of the sales SQL server."
    members = {
      user_principal_names = []
      group_keys             = []
      service_principal_keys = []
    }
    owners = {
      user_principal_names = []
      service_principal_keys = []
      object_ids             = []
    }
    prevent_duplicate_name = false
  }
}

azuread_roles = {
  mssql_servers = {
    mssqlserver1 = {
      roles = ["Directory Readers"]
    }
  }
}