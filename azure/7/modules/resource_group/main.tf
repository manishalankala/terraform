resource "azurerm_resource_group" "devrg" {
    name     = "dev_resourcegroup"
    location = "${var.location}"

    tags {
        environment = "DEV"
    }
}



output "id" {
  value = "${azurerm_resource_group.devrg.id}"
}

output "name" {
  value = "${azurerm_resource_group.devrg.name}"
}
