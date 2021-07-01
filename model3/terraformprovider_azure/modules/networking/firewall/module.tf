# Create resource group

resource "azurerm_resource_group" "add_resource_group" {
  name         = "${var.prefix}-resource_group"
  location     = var.location
  tags         = var.tags
  enviroment   = var.environment
}


# Create Vnet

resource "azurerm_virtual_network" "add_virtual_network" {
  name                    = "${var.prefix}-virtual_network"
  location                =  var.location
  resource_group_name     = azurerm_resource_group.add_resource_group.name
  address_space           = ["10.0.0.0/16"]
  dns_servers             = ["10.0.0.4", "10.0.0.5", "8.8,8.8", "1.1.1.1" ]
} 
    
# Create subnet
  
resource "azurerm_subnet" "add_fw_subnet" {
  name                   = "AzureFirewallSubnet"
  resource_group_name    = azurerm_resource_group.add_resource_group.name
  virtual_network_name   = azurerm_virtual_network.add_virtual_network.name
  address_prefixes       = ["10.0.4.0/22"]  
}

# Create publicip
  
resource "azurerm_public_ip" "add-publicip" {
  name                   = "${var.prefix}-publicip"
  location               = var.location
  resource_group_name    = azurerm_resource_group.add_resource_group.name
  allocation_method      = "Static"
  sku                    = "Standard"
}
  
# Create firewall  
  
resource "azurerm_firewall" "add_firewall" {
  name                = "${var.prefix}-firewall-subnet"
  location            = var.location
  resource_group_name = azurerm_resource_group.add_resource_group.name
  
  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.add_fw_subnet.id
    public_ip_address_id = azurerm_public_ip.add_publicip.id
  }
}
