terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.59.0"
    }
  }
  required_version = ">= 0.12"
}

provider "azurerm" {
  features {}
}
