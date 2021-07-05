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
