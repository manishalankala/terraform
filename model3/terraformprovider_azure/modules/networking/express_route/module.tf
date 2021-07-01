# Create resource group

resource "azurerm_resource_group" "add_resource_group" {
  name         = "${var.prefix}-resource_group"
  location     = var.location
  tags         = var.tags
  enviroment   = var.environment
}


resource "azurerm_express_route_circuit" "add_expressroute" {
  name                  = "${var.prefix}-express-route"
  resource_group_name   = azurerm_resource_group.add_resource_group.name
  location              = var.location
  service_provider_name = "Equinix"
  peering_location      = "Silicon Valley"
  bandwidth_in_mbps     = 50

  sku {
    tier   = "Standard"
    family = "MeteredData"
  }
  
    allow_classic_operations = false

  #tags = {
  #  environment = "Production"
  #}
  
}

resource "azurerm_express_route_circuit_authorization" "add_expressrouteauth" {
  name                       = "exampleERCAuth"
  express_route_circuit_name = azurerm_express_route_circuit.add_expressroute.name
  resource_group_name        = azurerm_resource_group.add_resource_group.name
}
