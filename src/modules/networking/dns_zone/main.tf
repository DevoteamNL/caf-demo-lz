resource "random_string" "dns_zone_name" {
  count   = var.settings.name == "" ? 1 : 0
  length  = 32
  special = false
  upper   = false
}

locals {
  dns_zone_name = var.settings.name == "" ? format("%s.com", random_string.dns_zone_name[0].result) : var.settings.name
}


resource "azurerm_dns_zone" "dns_zone" {
  name                = local.dns_zone_name
  resource_group_name = var.resource_group_name
  tags                = local.tags
}



module "records" {
  source     = "./records"
  count      = try(var.settings.records, null) == null ? 0 : 1
  depends_on = [azurerm_dns_zone.dns_zone]
  
  client_config       = var.client_config
  resource_group_name = var.resource_group_name
  records             = var.settings.records
  resource_ids        = var.resource_ids
  zone_name           = local.dns_zone_name
}