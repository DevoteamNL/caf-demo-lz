
# naming convention
resource "azurecaf_name" "rg" {
  name          = var.resource_group_name
  resource_type = "azurerm_resource_group"
  prefixes      = try(var.global_settings.prefixes, [])
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = try(var.global_settings.passthrough, true)
  use_slug      = try(var.global_settings.use_slug, false)
}

resource "azurerm_resource_group" "rg" {
  name     = azurecaf_name.rg.result
  location = var.global_settings.regions[lookup(var.settings, "region", var.global_settings.default_region)]
  tags = merge(
    var.tags,
    lookup(var.settings, "tags", {})
  )
}