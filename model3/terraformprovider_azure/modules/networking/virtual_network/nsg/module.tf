# Create Resource group

resource "azurerm_resource_group" "add_resource_group" {
  name         = "${var.prefix}-resource_group"
  location     = var.location
  tags         = var.tags
  enviroment   = var.environment
}

# Create nsg ssh

resource "azurerm_network_security_group" "add_nsg_ssh" {
  name                = "${var.prefix}-networksecuritygroup-ssh"
  location            = var.location
  resource_group_name = azurerm_resource_group.add_resource_group.name

  security_rule {
    name                            = "allow-ssh"
    priority                        = 100
    direction                       = "Inbound"
    access                          = "Allow"
    protocol                        = "Tcp"
    source_port_range               = "*"
    destination_port_range          = "22"
    source_address_prefix           = "0.0.0.0/0"
    destination_address_prefix      = "*"
  }

# Create nsg http 
  
resource "azurerm_network_security_group" "add_nsg_http" {
  name                = "${var.prefix}-networksecuritygroup-http"
  location            = var.location
  resource_group_name = azurerm_resource_group.add_resource_group.name

  security_rule {
    name                           = "allow-http"
    priority                       = 101
    direction                      = "Inbound"
    access                         = "Allow"
    protocol                       = "Tcp"
    source_port_range              = "*"
    destination_port_range         = "80"
    source_address_prefix          = "0.0.0.0/0"
    destination_address_prefix     = "*"
  }
  
# Create nsg https   
  
resource "azurerm_network_security_group" "add_nsg_https" {
  name                            = "${var.prefix}-networksecuritygroup-https"
  location                        = var.location
  resource_group_name             = azurerm_resource_group.add_resource_group.name

  security_rule {
    name                           = "allow-https"
    priority                       = 102
    direction                      = "Inbound"
    access                         = "Allow"
    protocol                       = "Tcp"
    source_port_range              = "*"
    destination_port_range         = "443"
    source_address_prefix          = "0.0.0.0/0"
    destination_address_prefix     = "*"
  }
  

# Create nsg rdp   
  
 resource "azurerm_network_security_group" "add_nsg_rdp" {
  name                = "${var.prefix}-networksecuritygroup-rdp"
  location            = var.location
  resource_group_name = azurerm_resource_group.add_resource_group.name

  security_rule {
    name                           = "allow-rdp"
    priority                       = 103
    direction                      = "Inbound"
    access                         = "Allow"
    protocol                       = "Tcp"
    source_port_range              = "*"
    destination_port_range         = "3389"
    source_address_prefix          = "0.0.0.0/0"
    destination_address_prefix     = "*"
  }
   

# Create nsg ftp
 
resource "azurerm_network_security_group" "add_nsg_ftp" {
  name                = "${var.prefix}-networksecuritygroup-ftp"
  location            = var.location
  resource_group_name = azurerm_resource_group.add_resource_group.name

  security_rule {
    name                           = "allow-ftp"
    priority                       = 104
    direction                      = "Inbound"
    access                         = "Allow"
    protocol                       = "Tcp"
    source_port_range              = "*"
    destination_port_range         = "21"
    source_address_prefix          = "0.0.0.0/0"
    destination_address_prefix     = "*"
  }   

  
# Create nsg winrm
  
resource "azurerm_network_security_group" "add_nsg_winrm" {
  name                             = "${var.prefix}-networksecuritygroup-winrm"
  location                         = var.location
  resource_group_name              = azurerm_resource_group.add_resource_group.name

  security_rule {
    name                           = "allow-ftp"
    priority                       = 104
    direction                      = "Inbound"
    access                         = "Allow"
    protocol                       = "Tcp"
    source_port_range              = "*"
    destination_port_range         = "5986"
    source_address_prefix          = "0.0.0.0/0"
    destination_address_prefix     = "*"
  } 
