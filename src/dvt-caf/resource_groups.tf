module "resource_groups" {
  source = "./modules/resource_group"
  for_each = {
    for key, value in try(var.resource_groups, {}) : key => value
    if try(value.reuse, false) == false
  }

  resource_group_name = each.value.name
  settings            = each.value
  global_settings     = var.global_settings
  tags                = merge(lookup(each.value, "tags", {}), var.tags)
}

output "resource_groups" {
  value = var.resource_groups
}