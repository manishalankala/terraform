resource "azurerm_resource_group" "add_resource_group" {
  name         = "${var.prefix}-resource_group"
  location     = var.location
  tags         = var.tags
  enviroment   = var.environment
}

resource "azurerm_network_watcher" "add_watcher" {
  name                = "${var.prefix}-network-watcher"
  location            = var.location
  resource_group_name = azurerm_resource_group.add_resource_group.name
}
