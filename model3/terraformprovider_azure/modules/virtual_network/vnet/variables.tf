variable "resource_group_name" {
  type   = string
}


variable "azurerm_network_security_group" {
  type   = string
}


variable "subnets" {
  type   = list(string)
}


