## The Managed Identity used by the AKS
managed_identities = {
  aks_usermsi = {
    name               = "aks-usermsi"
    resource_group_key = "aks_re1"
  }
}