resource "azurerm_resource_group" "add_resource_group" {
  name         = "${var.prefix}-resource_group"
  location     = var.location
  tags         = var.tags
  enviroment   = var.environment
}

resource "azurerm_virtual_network" "add_virtual_network" {
  name                      = "${var.prefix}-virtual_network"
  address_space             = ["10.0.0.0/16"]
  location                  = var.location
  resource_group_name       = azurerm_resource_group.add_resource_group.name
}



resource "azurerm_subnet" "add_subnet" {
  name                      = "appgateway-subnet"
  resource_group_name       = azurerm_resource_group.add_resource_group.name
  virtual_network_name      = azurerm_virtual_network.add_virtual_network.name
  address_prefixes          = ["10.0.1.0/22"]



resource "azurerm_subnet" "add_subnet" {
  name                 = "management-subnet"
  resource_group_name  = azurerm_resource_group.add_resource_group.name
  virtual_network_name = azurerm_virtual_network.add_virtual_network.name
  address_prefixes     = ["10.0.2.0/22"]

     
  
resource "azurerm_subnet" "add_subnet" {
  name                 = "resource-subnet"
  resource_group_name  = azurerm_resource_group.add_resource_group.name
  virtual_network_name = azurerm_virtual_network.add_virtual_network.name
  address_prefixes     = ["10.0.3.0/22"]
  
  
  delegation {
    name = "delegation"

    service_delegation {
      name    = "Microsoft.ContainerInstance/containerGroups"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
    }
  }
}
