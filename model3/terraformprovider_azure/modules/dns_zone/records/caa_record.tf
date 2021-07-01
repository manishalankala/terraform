# Create resource group

resource "azurerm_resource_group" "add_resource_group" {
  name         = "${var.prefix}-resource_group"
  location     = var.location
  tags         = var.tags
  enviroment   = var.environment
}


resource "azurerm_dns_zone" "add_dns_arecord" {
  name                    = "netflix.com"
  resource_group_name     = azurerm_resource_group.add_resource_group.name

resource "azurerm_dns_caa_record" "add_dns" {
  name                = "test"
  zone_name           = azurerm_dns_zone.example.name
  resource_group_name = azurerm_resource_group.example.name
  ttl                 = 300

  record {
    flags = 0
    tag   = "issue"
    value = "example.com"
  }

  record {
    flags = 0
    tag   = "issue"
    value = "example.net"
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

  tags = {
    Environment = "Production"
  }
}
