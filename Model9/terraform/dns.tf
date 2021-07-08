provider "azurerm" {
}

resource "azurerm_resource_group" "hub-rg" {
  name     = "${var.region}-${var.environment}-${var.app_name}-hub-rg"
  location = "West Europe"
}

# Note: 
# MX – specifies where the emails for your domain should be delivered.
# TXT – used to store text-based information related to your domain. Most commonly used for storing SPF data.
# SPF – a mail validation protocol used to prevent email spoofing.
# AAAA – it maps a domain name to the IP address (IPv6) of the computer hosting the domain.
# SRV – stands for Service Record and it specifies on only an IP but also a port.
# Verifying Azure DNS Zone Configuration 
# nslookup www.mydomaincom.com <name server name>
# example: nslookup www.mydomaincom.com ns1-08.azure-dns.com
# Adding Alias Record Set for Public IP choose 1.Azure resource 2.Zone record set the choose subcription then azure resource= PUBLICIP
# 1.dns zone 2.Record 3.PUBLIC IP




########################################
## A DNS zone is used to host the DNS records for a particular website domain.
########################################

resource "azurerm_dns_zone" "mydomaincom" {
  name                = "mydomain.com" # replace with your domain
  resource_group_name = "${azurerm_resource_group.dns_management.name}"
}


###### A ############################
# A-record is the record contains the pairing between the IP address and the domain name. 
# It can have more than one entries usually known as record sets. 
# In record sets, the domain name remains constant, while the IP addresses are different.
####################################

resource "azurerm_dns_a_record" "projectmydomain" {
  name                = "project"
  zone_name           = "${azurerm_dns_zone.mydomaincom.name}"
  resource_group_name = "${azurerm_resource_group.hub-rg.name}"
  ttl                 = 300
  records             = ["PUBLIC IP"].    ### enter the public IP address for your web server
}

####################################
### CNAME – specifies redirects from your domain’s subdomains to other domains/subdomains ###
####################################

resource "azurerm_dns_cname_record" "awesomemydomain" {
  name                = "awesome"
  zone_name           = "${azurerm_dns_zone.mydomaincom.name}"
  resource_group_name = "${azurerm_resource_group.dns_management.name}"
  ttl                 = 300
  record              = "dev.mydomain.com"
}




  


      
