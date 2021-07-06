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

  type     = "ExpressRoute"
  vpn_type = "RouteBased"

  active_active = false
  enable_bgp    = false
  sku           = "Standard"

  ip_configuration {
    name                          = "${var.region}-${var.environment}-${var.app_name}-vnet"
    public_ip_address_id          = azurerm_public_ip.public-gateway-ip.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.gateway-subnet.id
  }
  
# Create route circuit 
  
resource "azurerm_express_route_circuit" "route-circuit" {
  name                  = "expressRoute1"
  resource_group_name   = azurerm_resource_group.hub-rg.name
  location              = azurerm_resource_group.hub-rg.location
  service_provider_name = "Equinix"
  peering_location      = "Silicon Valley"
  bandwidth_in_mbps     = 50

  sku {
    tier   = "Standard"
    family = "MeteredData"
  }
