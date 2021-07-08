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


#### A – specifies IP addresses corresponding to your domain and its subdomains ###


resource "azurerm_dns_a_record" "projectmydomain" {
  name                = "project"
  zone_name           = "${azurerm_dns_zone.mydomaincom.name}"
  resource_group_name = "${azurerm_resource_group.hub-rg.name}"
  ttl                 = 300
  records             = ["127.0.0.1"]
}


### CNAME – specifies redirects from your domain’s subdomains to other domains/subdomains ###

resource "azurerm_dns_cname_record" "awesomemydomain" {
  name                = "awesome"
  zone_name           = "${azurerm_dns_zone.mydomaincom.name}"
  resource_group_name = "${azurerm_resource_group.dns_management.name}"
  ttl                 = 300
  record              = "dev.mydomain.com"
}

MX – specifies where the emails for your domain should be delivered.
CNAME – specifies redirects from your domain’s subdomains to other domains/subdomains.
TXT – used to store text-based information related to your domain. Most commonly used for storing SPF data.
SPF – a mail validation protocol used to prevent email spoofing.
AAAA – it maps a domain name to the IP address (IPv6) of the computer hosting the domain.
SRV – stands for Service Record and it specifies on only an IP but also a port.
