resource "azurerm_resource_group" "run_resource_group" {
  name         = "${var.prefix}-resource_group"
  location     = var.location
  tags         = var.tags
  enviroment   = var.environment
}
