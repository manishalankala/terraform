# Create a Resource Group

resource "azurerm_resource_group" "hub-rg" {
  name     = "${var.region}-${var.environment}-${var.app_name}-hub-rg"
  location = var.location
  tags = {
    environment = var.environment
  }
}

# Create the VNET

resource "azurerm_virtual_network" "hub-vnet" {
  name                = "${var.region}-${var.environment}-${var.app_name}-hub-vnet"
  address_space       = [var.hub-vnet]
  location              = azurerm_resource_group.hub-rg.location
  resource_group_name   = azurerm_resource_group.hub-rg.name
  tags = {
    environment = var.environment
  }
}

# Create a Gateway Subnet

resource "azurerm_subnet" "gateway-subnet" {
  name                 = "GatewaySubnet" # do not rename
  address_prefixes     = [var.gateway-subnet]
  virtual_network_name = azurerm_virtual_network.hub-vnet.name
  resource_group_name  = azurerm_resource_group.hub-rg.name
}

# Create a Hub Subnet

resource "azurerm_subnet" "hub-subnet" {
  name                 = "hub-resources-subnet" # do not rename
  address_prefixes     = [var.hub-resources-subnet]
  virtual_network_name = azurerm_virtual_network.hub-vnet.name
  resource_group_name  = azurerm_resource_group.hub-rg.name
}

#################################
##### PublicIp & site to site Vpn
##################################


# Create gateway onprem to Azure 

resource "azurerm_local_network_gateway" "onprem" {
  name                = "onprem-azure"
  resource_group_name = azurerm_resource_group.hub-rg.name
  location            = azurerm_resource_group.hub-rg.location
  gateway_address     = "12.13.14.15"       ## Public ip of on-prem device
  address_space       = ["10.0.0.0/16"]     ## address range of local on-prem
}

# Create a Public IP for the Gateway

resource "azurerm_public_ip" "public-gateway-ip" {
  name                = "${var.region}-${var.environment}-${var.app_name}-gw-ip"
  location            = azurerm_resource_group.hub-rg.location
  resource_group_name = azurerm_resource_group.hub-rg.name
  allocation_method   = "Dynamic"
}

# Create VPN Gateway

resource "azurerm_virtual_network_gateway" "vpn-gateway" {
  name                = "${var.region}-${var.environment}-${var.app_name}-vpn-gw"
  location            = azurerm_resource_group.hub-rg.location
  resource_group_name = azurerm_resource_group.hub-rg.name

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = false
  enable_bgp    = false
  sku           = "Basic"

  ip_configuration {
    name                          = "${var.region}-${var.environment}-${var.app_name}-hub-vnet"
    public_ip_address_id          = azurerm_public_ip.public-gateway-ip.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.gateway-subnet.id
  }
  
    vpn_client_configuration {
    address_space = ["10.3.0.0/24"]

    root_certificate {
      name = "DigiCert-Federated-ID-Root-CA"

      public_cert_data = <<EOF
MIIDuzCCAqOgAwIBAgIQCHTZWCM+IlfFIRXIvyKSrjANBgkqhkiG9w0BAQsFADBn
MQswCQYDVQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYDVQQLExB3
d3cuZGlnaWNlcnQuY29tMSYwJAYDVQQDEx1EaWdpQ2VydCBGZWRlcmF0ZWQgSUQg
Um9vdCBDQTAeFw0xMzAxMTUxMjAwMDBaFw0zMzAxMTUxMjAwMDBaMGcxCzAJBgNV
BAYTAlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdp
Y2VydC5jb20xJjAkBgNVBAMTHURpZ2lDZXJ0IEZlZGVyYXRlZCBJRCBSb290IENB
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAvAEB4pcCqnNNOWE6Ur5j
QPUH+1y1F9KdHTRSza6k5iDlXq1kGS1qAkuKtw9JsiNRrjltmFnzMZRBbX8Tlfl8
zAhBmb6dDduDGED01kBsTkgywYPxXVTKec0WxYEEF0oMn4wSYNl0lt2eJAKHXjNf
GTwiibdP8CUR2ghSM2sUTI8Nt1Omfc4SMHhGhYD64uJMbX98THQ/4LMGuYegou+d
GTiahfHtjn7AboSEknwAMJHCh5RlYZZ6B1O4QbKJ+34Q0eKgnI3X6Vc9u0zf6DH8
Dk+4zQDYRRTqTnVO3VT8jzqDlCRuNtq6YvryOWN74/dq8LQhUnXHvFyrsdMaE1X2
DwIDAQABo2MwYTAPBgNVHRMBAf8EBTADAQH/MA4GA1UdDwEB/wQEAwIBhjAdBgNV
HQ4EFgQUGRdkFnbGt1EWjKwbUne+5OaZvRYwHwYDVR0jBBgwFoAUGRdkFnbGt1EW
jKwbUne+5OaZvRYwDQYJKoZIhvcNAQELBQADggEBAHcqsHkrjpESqfuVTRiptJfP
9JbdtWqRTmOf6uJi2c8YVqI6XlKXsD8C1dUUaaHKLUJzvKiazibVuBwMIT84AyqR
QELn3e0BtgEymEygMU569b01ZPxoFSnNXc7qDZBDef8WfqAV/sxkTi8L9BkmFYfL
uGLOhRJOFprPdoDIUBB+tmCl3oDcBy3vnUeOEioz8zAkprcb3GHwHAK+vHmmfgcn
WsfMLH4JCLa/tRYL+Rw/N3ybCkDp00s0WUZ+AoDywSl0Q/ZEnNY0MsFiw6LyIdbq
M/s/1JRtO3bDSzD9TazRVzn2oBqzSa8VgIo5C1nOnoAKJTlsClJKvIhnRlaLQqk=
EOF
    }

  }
}

# Create connection between on prem
  
resource "azurerm_virtual_network_gateway_connection" "onpremconnection" {
    name                       = onpremiseconnection
    location                   = azurerm_resource_group.hub-rg.location
    resource_group_name        = azurerm_resource_group.hub-rg.name
    type                       = "IPsec"
    virtual_network_gateway_id = azurerm_virtual_network_gateway.vpn-gateway.id
    local_network_gateway_id   = azurerm_local_network_gateway.onprem.id
    shared_key                 = var.vpn_psk #-Provided at run time or 4-v3ry-53cr37-1p53c-5h4r3d-k3y
}

  


#########################
##### SPOKE1  #####
#########################



# Create a Resource Group

resource "azurerm_resource_group" "spoke1-rg" {
  name     = "${var.region}-${var.environment}-${var.app_name}-spoke1-rg"
  location = var.location
  tags = {
    environment = var.environment
  }
}





# Create the SPOKE1-VNET

resource "azurerm_virtual_network" "spoke1-vnet" {
  name                = "${var.region}-${var.environment}-${var.app_name}-spoke1-vnet"
  address_space       = [var.spoke1-vnet]
  location              = azurerm_resource_group.spoke1-rg.location
  resource_group_name   = azurerm_resource_group.spoke1-rg.name
  tags = {
    environment = var.environment
  }
}

# Create a SPOKE1-Subnet1

resource "azurerm_subnet" "spokeone-subnet" {
  name                 = "spoke1-subnet" # do not rename
  address_prefixes     = [var.spoke1-subnet1]
  virtual_network_name = azurerm_virtual_network.spoke1-vnet.name
  resource_group_name  = azurerm_resource_group.spoke1-rg.name
}

# Create a SPOKE1-Subnet2

resource "azurerm_subnet" "spoketwo-subnet" {
  name                 = "spoke2-subnet" # do not rename
  address_prefixes     = [var.spoke1-subnet1]
  virtual_network_name = azurerm_virtual_network.spoke1-vnet.name
  resource_group_name  = azurerm_resource_group.spoke1-rg.name
}

resource "azurerm_virtual_network_peering" "spoke1-peering-hub" {
  name                         = "spoke1-hub"
  resource_group_name          = azurerm_resource_group.hub-rg.name
  virtual_network_name         = azurerm_virtual_network.spoke1-vnet.name
  remote_virtual_network_id    = azurerm_virtual_network.hub-vnet.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = false
  use_remote_gateways          = true
  depends_on = [azurerm_virtual_network.spoke1-vnet, azurerm_virtual_network.hub-vnet , azurerm_virtual_network_gateway.vpn-gateway]
}



#########################
##### SPOKE1  #####
#########################



# Create a Resource Group

resource "azurerm_resource_group" "spoke1-rg" {
  name     = "${var.region}-${var.environment}-${var.app_name}-spoke1-rg"
  location = var.location
  tags = {
    environment = var.environment
  }
}



# Create the SPOKE2-VNET

resource "azurerm_virtual_network" "spoke2-vnet" {
  name                  = "${var.region}-${var.environment}-${var.app_name}-spoke2-vnet"
  address_space         = [var.spoke2-vnet]
  location              = azurerm_resource_group.spoke2-rg.location
  resource_group_name   = azurerm_resource_group.spoke2-rg.name
  tags = {
    environment = var.environment
  }
}

# Create a SPOKE2-Subnet1

resource "azurerm_subnet" "spokeone-subnet" {
  name                 = "spoke2-subnet" # do not rename
  address_prefixes     = [var.spoke2-subnet1]
  virtual_network_name = azurerm_virtual_network.spoke2-vnet.name
  resource_group_name  = azurerm_resource_group.spoke2-rg.name
}

# Create a SPOKE2-Subnet2

resource "azurerm_subnet" "spoketwo-subnet" {
  name                 = "spoke2-subnet" # do not rename
  address_prefixes     = [var.spoke2-subnet1]
  virtual_network_name = azurerm_virtual_network.spoke2-vnet.name
  resource_group_name  = azurerm_resource_group.spoke2-rg.name
}

resource "azurerm_virtual_network_peering" "spoke2-peering-hub" {
  name                         = "spoke2-hub"
  resource_group_name          = azurerm_resource_group.hub-rg.name
  virtual_network_name         = azurerm_virtual_network.spoke2-vnet.name
  remote_virtual_network_id    = azurerm_virtual_network.hub-vnet.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = false
  use_remote_gateways          = true
  depends_on = [azurerm_virtual_network.spoke2-vnet, azurerm_virtual_network.hub-vnet , azurerm_virtual_network_gateway.vpn-gateway]
}
