# Should either be a list of records or a target_resource_id (Alias)
resource "azurerm_dns_a_record" "this" {
  for_each = { for record in var.a_recordsets :
    record.name => record
  }


  resource_group_name = lower(var.resource_group_name)
  zone_name           = var.zone_name

  name    = lower(each.value.name)
  ttl     = each.value.ttl
  records = length(lookup(each.value, "record", [])) == 0 ? null : each.value.record
}
