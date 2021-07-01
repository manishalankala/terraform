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

  
# Create record 
  
resource "azurerm_dns_caa_record" "add_dns_caarecord" {
  name                = "test"
  zone_name           = azurerm_dns_zone.add_zone_public.name
  resource_group_name = azurerm_resource_group.add_resource_group.name
  ttl                 = 300

  record {
    flags = 0
    tag   = "issue"
    value = "netflix.com"
  }

  record {
    flags = 0
    tag   = "issue"
    value = "netflix.net"
  }

  record {
    flags = 0
    tag   = "issuewild"
    value = ";"
  }

  record {
    flags = 0
    tag   = "iodef"
    value = "mailto:terraform@nonexisting.tld"
  }

  #tags = {
  #  Environment = "Production"
  #}
}
