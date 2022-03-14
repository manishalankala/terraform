resource "azurerm_private_dns_srv_record" "this" {
  for_each = { for record in var.srv_recordsets :
    record.name => record
  }

  resource_group_name = lower(var.resource_group_name)
  zone_name           = var.zone_name

  name = lower(each.value.name)
  ttl  = each.value.ttl

  dynamic "record" {
    for_each = each.value.record
    content {
      priority = split(",", record.value)[0]
      weight   = split(",", record.value)[1]
      port     = split(",", record.value)[2]
      target   = split(",", record.value)[3]
    }
  }
}
