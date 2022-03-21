output "id" {
  value = "${azurerm_virtual_network.terraformnetwork.id}"
}

output "name" {
  value = "${azurerm_virtual_network.terraformnetwork.name}"
}

output "nic" {
  value = "${azurerm_network_interface.terraformnic.id}"
}
