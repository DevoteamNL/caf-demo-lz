


output "global_settings" {
  value     = module.dvt-caf-launcher.global_settings  
  sensitive = true
}


output "tfstates" {
  value     = local.tfstates
  sensitive = true
}



