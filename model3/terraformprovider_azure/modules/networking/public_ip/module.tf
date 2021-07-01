# Create Resource group

resource "azurerm_resource_group" "add_resource_group" {
  name         = "${var.prefix}-resource_group"
  location     = var.location
  tags         = var.tags
  enviroment   = var.environment
}


resource "azurerm_public_ip" "add_publicip" {
  name                = "${var.prefix}-publicip"
  resource_group_name = azurerm_resource_group.add_resource_group.name
  location            = var.location
  allocation_method   = "Static"

  #tags = {
  #  environment = "Production"
  #}
  
}
