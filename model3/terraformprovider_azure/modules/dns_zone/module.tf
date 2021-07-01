# Create resource group

resource "azurerm_resource_group" "add_resource_group" {
  name         = "${var.prefix}-resource_group"
  location     = var.location
  tags         = var.tags
  enviroment   = var.environment
}


resource "azurerm_dns_zone" "add_zone_public" {
  name                  = "netflix.com"
  resource_group_name   = azurerm_resource_group.add_resource_group.name
}


resource "azurerm_dns_zone" "add_zone_private" {
  name                  = "netflix.com"
  resource_group_name   = azurerm_resource_group.add_resource_group.name
}
