landingzone = {
  backend_type        = "azurerm"
  level               = "level2"
  key                 = "asvm"
  global_settings_key = "management"
  tfstates = {
    management = {
      tfstate   = "management.tfstate"
      workspace = "tfstate"
      level     = "lower"
    }
  }
}
