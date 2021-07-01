
resource "azurerm_resource_group" "add_resource_group" {
  name         = "${var.prefix}-resource_group"
  location     = var.location
  tags         = var.tags
  enviroment   = var.environment
}



resource "azurerm_virtual_network" "add_virtual_network" {
  name                     = "${var.prefix}-virtual_network
  vnet_address_space       = ["10.0.0.0/16"]
  location                 = var.location
  resource_group_name      = azurerm_resource_group.add_resource_group.name
}



resource "azurerm_subnet" "example" {
  name                 = "example-subnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]
