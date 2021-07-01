# Create resource group

resource "azurerm_resource_group" "add_resource_group" {
  name         = "${var.prefix}-resource_group"
  location     = var.location
  tags         = var.tags
  enviroment   = var.environment
}

# Create zone

resource "azurerm_dns_zone" "add_zone_public" {
  name                    = "netflix.com"
  resource_group_name     = azurerm_resource_group.add_resource_group.name
}


# Create record 

resource "azurerm_dns_a_record" "add_dns_arecord" {
  name                    = "${var.prefix}-a-record"
  zone_name               = azurerm_dns_zone.add_zone.name
  resource_group_name     = azurerm_resource_group.add_resource_group.name
  ttl                     = 300
  records                 = ["10.0.180.17"]
}
