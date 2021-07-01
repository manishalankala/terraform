# Create resource group

resource "azurerm_resource_group" "add_resource_group" {
  name         = "${var.prefix}-resource_group"
  location     = var.location
  tags         = var.tags
  enviroment   = var.environment
}

resource "azurerm_route_table" "add-routetable" {
  name                          = "${var.prefix}-routetable"
  location                      = var.location
  resource_group_name           = azurerm_resource_group.add_resource_group.name
  disable_bgp_route_propagation = false

  route {
    name           = "External"
    address_prefix = "0.0.0.0/0"
    next_hop_type  = "Internet"
  }

  route {
    name           = "Local"
    address_prefix = "10.0.0.0/16"
    next_hop_type  = "VnetLocal"
  }
  
  
  
  #tags = {
  #  environment = "Production"
  #}
  
}
