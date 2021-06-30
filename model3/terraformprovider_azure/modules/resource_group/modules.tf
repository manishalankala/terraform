resource "azurerm_resource_group" "netflix_resource_group" {
  name     = "$(var.prefix)-resource_group"
  location = var.location
  tags     = var.tag_environment
}
