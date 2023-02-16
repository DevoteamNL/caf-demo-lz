
output "objects" {
  value = tomap(
    { (var.landingzone.key) = {
      for key, value in module.dvt-caf-remote-setup : key => value
      if try(value, {}) != {}
      }
    }
  )
  sensitive = true
}

output "global_settings" {
  value     = module.dvt-caf-remote-setup.global_settings
  sensitive = true
}


output "tfstates" {
  value     = local.tfstates
  sensitive = true
}


output "launchpad_identities" {
  value = var.propagate_launchpad_identities ? {
    (var.landingzone.key) = {
      azuread_groups     = try(module.dvt-caf-remote-setup.azuread_groups, {})
      managed_identities = try(module.dvt-caf-remote-setup.managed_identities, {})
    }
  } : {}
  sensitive = true
}
