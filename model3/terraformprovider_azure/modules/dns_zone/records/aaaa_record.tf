# Create resource group

resource "azurerm_resource_group" "add_resource_group" {
  name         = "${var.prefix}-resource_group"
  location     = var.location
  tags         = var.tags
  enviroment   = var.environment
}

# Create dns_zone

resource "azurerm_dns_zone" "add_dns_aaaarecord" {
  name                    = "netflix.com"
  resource_group_name     = azurerm_resource_group.add_resource_group.name
}


resource "azurerm_dns_aaaa_record" "add_dns_aaaarecord" {
  name                    = "test"
  zone_name               = azurerm_dns_zone.add_dns_aaaarecord.name
  resource_group_name     = azurerm_resource_group.add_resource_group.name
  ttl                     = 300
  records                 = ["2001:db8::1:0:0:1"]
}
