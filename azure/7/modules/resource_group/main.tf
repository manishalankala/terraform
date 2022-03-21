resource "azurerm_resource_group" "devrg" {
    name     = "dev_resourcegroup"
    location = "${var.location}"

    tags {
        environment = "DEV"
    }
}
