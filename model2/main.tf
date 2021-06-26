provider "azurerm" {
    version = "2.5.0"
    features {}
}

terraform {
    backend "azurerm" {
        resource_group_name  = "rg_blobstore"
        storage_account_name = "storagebin"
        container_name       = "con1"
        key                  = "terraform.tfstate"
    }
}

variable "imagebuild" {
  type        = string
  description = "Latest Image Build"
}



resource "azurerm_resource_group" "resource_env_test" {
  
  name = "resourcetest"
  location = "westeurope"
}

resource "azurerm_container_group" "container_env_test" {
  name                      = "con1_test"
  location                  = azurerm_resource_group.resource_env_test.location
  resource_group_name       = azurerm_resource_group.resource_env_test.name

  ip_address_type     = "public"
  dns_name_label      = "testdns"
  os_type             = "Linux"

  container {
      name            = "con1_test"
      image           = "azuretesthub/con1_test:${var.imagebuild}"
        cpu             = "1"
        memory          = "1"

        ports {
            port        = 80
            protocol    = "TCP"
        }
  }
}
