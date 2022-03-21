# Create storage account for boot diagnostics
resource "azurerm_storage_account" "devsa" {
    name                = "devstorageaccount"
    resource_group_name = "${var.resource_group_name}"
    location            = "${var.location}"
    account_type        = "Standard_LRS"

    tags {
        environment = "DEV"
    }
}

resource "azurerm_storage_container" "devsc" {
  name                  = "vhds"
  resource_group_name   = "${var.resource_group_name}"
  storage_account_name  = "${azurerm_storage_account.mystorageaccount.name}"
  container_access_type = "private"
}

resource "azurerm_storage_blob" "devsb" {
  name                   = "sample.vhd"
  resource_group_name    = "${var.resource_group_name}"
  storage_account_name   = "${azurerm_storage_account.mystorageaccount.name}"
  storage_container_name = "${azurerm_storage_container.mystoragecontainer.name}"

  type = "page"
  size = 5120
}
