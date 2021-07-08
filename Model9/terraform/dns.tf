provider "azurerm" {
}

resource "azurerm_resource_group" "hub-rg" {
  name     = "${var.region}-${var.environment}-${var.app_name}-hub-rg"
  location = "West Europe"
}


resource "azurerm_dns_zone" "mydomaincom" {
  name                = "mydomain.com" # replace with your domain
  resource_group_name = "${azurerm_resource_group.dns_management.name}"
}


resource "azurerm_dns_a_record" "projectmydomain" {
  name                = "project"
  zone_name           = "${azurerm_dns_zone.mydomaincom.name}"
  resource_group_name = "${azurerm_resource_group.hub-rg.name}"
  ttl                 = 300
  records             = ["127.0.0.1"]
}
