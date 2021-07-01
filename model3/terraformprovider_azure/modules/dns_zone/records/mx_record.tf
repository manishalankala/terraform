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

resource "azurerm_dns_mx_record" "add_dns_mxrecord" {
  name                = "${var.prefix}-mx-record"
  zone_name           = azurerm_dns_zone.add_zone_public.name
  resource_group_name = azurerm_resource_group.add_resource_group.name
  ttl                 = 300

  record {
    preference = 10
    exchange   = "mail1.netflix.com"
  }

  record {
    preference = 20
    exchange   = "mail2.netflix.com"
  }

  #tags = {
  #  Environment = "Production"
  #}
}

