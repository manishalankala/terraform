resource "azurerm_dns_cname_record" "this" {
  for_each = { for record in var.cname_records :
    record.name => record
  }

  resource_group_name = lower(var.resource_group_name)
  zone_name           = var.zone_name

  name   = lower(each.value.name)
  ttl    = each.value.ttl
  record = lower(each.value.record)
}
