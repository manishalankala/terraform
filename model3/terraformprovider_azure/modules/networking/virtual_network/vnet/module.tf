


# Create resource group

resource "azurerm_resource_group" "add_resource_group" {
  name         = "${var.prefix}-resource_group"
  location     = var.location
  tags         = var.tags
  enviroment   = var.environment
}


# Create Network secuirty group

resource "azurerm_network_security_group" "add_network_security_group" {
  name                    = "${var.prefix}-network_security_group"
  location                = var.location
  resource_group_name     = azurerm_resource_group.add_resource_group.name
}


# Create ddos 

resource "azurerm_network_ddos_protection_plan" "add_ddos" {
  name                    = "ddospplan1"
  location                = var.location
  resource_group_name     = azurerm_resource_group.add_resource_group.name
}


# Create Vnet

resource "azurerm_virtual_network" "add_virtual_network" {
  name                    = "${var.prefix}-virtual_network"
  location                =  var.location
  resource_group_name     = azurerm_resource_group.add_resource_group.name
  address_space           = ["10.0.0.0/16"]
  dns_servers             = ["10.0.0.4", "10.0.0.5", "8.8,8.8", "1.1.1.1" ]
  
  
  ddos_protection_plan {
    id     = azurerm_network_ddos_protection_plan.add_ddos.id
    enable = false
  }
  

# Create Subnets under Vnet
  
subnets = {
    appg_subnet = {
      subnet_name                 = "appgateway-subnet"
      subnet_address_prefix       = ["10.0.1.0/22"]
      resource_group_name         = azurerm_resource_group.add_resource_group.name
      virtual_network_name        = azurerm_virtual_network.add_virtual_network.name
      service_endpoints           = ["Microsoft.Storage"]
    }
    
    mgmt_subnet = {
      subnet_name                 = "management-subnet"
      subnet_address_prefix       = ["10.0.2.0/22"]
      resource_group_name         = azurerm_resource_group.add_resource_group.name
      virtual_network_name        = azurerm_virtual_network.add_virtual_network.name
      service_endpoints           = ["Microsoft.Storage"]
    }
    
    res_subnet = {
      subnet-name                 = "resource-subnet"
      subnet_address_prefix       = ["10.0.3.0/22"]
      resource_group_name         = azurerm_resource_group.add_resource_group.name
      virtual_network_name        = azurerm_virtual_network.add_virtual_network.name
      service_endpoints           = ["Microsoft.Storage"]
    }  
     
      

  
  
  
  
  
#  resource "azurerm_subnet" "add_appg_subnet"
#  depends_on           = ["azurerm_virtual_network.add_virtual_network"]
#  virtual_network_name = var.virtual_network_name
#  name                 = "appgateway-subnet"
#  address_prefixes     = ["10.0.1.0/22"]
#  resource_group_name  = var.resource_group_name
#}

#resource "azurerm_subnet" "add_mgmt_subnet"
# depends_on           = ["azurerm_virtual_network.add_virtual_network"]
# virtual_network_name = var.virtual_network_name
# name                 = "management-subnet"
# address_prefixes     = ["10.0.2.0/22"]
# resource_group_name  = var.resource_group_name
#

#resource "azurerm_subnet" "add_res_subnet"
# depends_on           = ["azurerm_virtual_network.add_virtual_network"]
# virtual_network_name = var.virtual_network_name
# name                 = "res-subnet"
# address_prefixes     = ["10.0.3.0/22"]
# resource_group_name  = var.resource_group_name
#
