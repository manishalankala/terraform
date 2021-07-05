



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
    name                          = "${var.region}-${var.environment}-${var.app_name}-vnet"
    public_ip_address_id          = azurerm_public_ip.public-gateway-ip.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.gateway-subnet.id
  }

  vpn_client_configuration {
    address_space = ["10.3.0.0/24"]

    root_certificate {
      name = "VPNROOT"

      public_cert_data = data.azurerm_key_vault_secret.vpn-root-certificate.value
    }

  }
}




# Create the SPOKE1-VNET

resource "azurerm_virtual_network" "spoke1-vnet" {
  name                = "${var.region}-${var.environment}-${var.app_name}-spoke1-vnet"
  address_space       = [var.spoke1-vnet]
  location              = azurerm_resource_group.hub-rg.location
  resource_group_name   = azurerm_resource_group.hub-rg.name
  tags = {
    environment = var.environment
  }
}

# Create a SPOKE1-Subnet1

resource "azurerm_subnet" "spokeone-subnet" {
  name                 = "spoke1-subnet" # do not rename
  address_prefixes     = [var.spoke1-subnet1]
  virtual_network_name = azurerm_virtual_network.spoke1-vnet.name
  resource_group_name  = azurerm_resource_group.hub-rg.name
}

# Create a SPOKE1-Subnet2

resource "azurerm_subnet" "spoketwo-subnet" {
  name                 = "spoke2-subnet" # do not rename
  address_prefixes     = [var.spoke1-subnet1]
  virtual_network_name = azurerm_virtual_network.spoke1-vnet.name
  resource_group_name  = azurerm_resource_group.hub-rg.name
}



# Create the SPOKE2-VNET

resource "azurerm_virtual_network" "spoke2-vnet" {
  name                = "${var.region}-${var.environment}-${var.app_name}-spoke2-vnet"
  address_space       = [var.spoke1-vnet]
  location              = azurerm_resource_group.hub-rg.location
  resource_group_name   = azurerm_resource_group.hub-rg.name
  tags = {
    environment = var.environment
  }
}

# Create a SPOKE1-Subnet1

resource "azurerm_subnet" "spokeone-subnet" {
  name                 = "spoke1-subnet" # do not rename
  address_prefixes     = [var.spoke1-subnet1]
  virtual_network_name = azurerm_virtual_network.spoke2-vnet.name
  resource_group_name  = azurerm_resource_group.hub-rg.name
}

# Create a SPOKE1-Subnet2

resource "azurerm_subnet" "spoketwo-subnet" {
  name                 = "spoke2-subnet" # do not rename
  address_prefixes     = [var.spoke1-subnet1]
  virtual_network_name = azurerm_virtual_network.spoke2-vnet.name
  resource_group_name  = azurerm_resource_group.hub-rg.name
}


