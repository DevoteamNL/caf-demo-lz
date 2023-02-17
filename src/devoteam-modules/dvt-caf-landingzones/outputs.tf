output "objects" {
  value = tomap(
    {
      (var.landingzone.key) = {
        for key, value in module.landingzone : key => value
        if try(value, {}) != {}
      }
    }
  )
  sensitive = true
}

output "global_settings" {
  value     = local.global_settings
  sensitive = true
}

output "tfstates" {
  value     = local.tfstates
  sensitive = true
}
