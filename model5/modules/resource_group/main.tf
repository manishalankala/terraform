resource "azurerm_resource_group" "devrg" {
    name     = "myResourceGroup"
    location = "${var.location}"

    tags {
        environment = "DEV"
    }
}
