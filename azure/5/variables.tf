################################
## Azure Provider - Variables ##
################################

# Azure authentication variables
variable "azure-subscription-id" {
  type        = string
  description = "Azure Subscription ID"
}

variable "azure-client-id" {
  type        = string
  description = "Azure Client ID"
}

variable "azure-client-secret" {
  type        = string
  description = "Azure Client Secret"
}

variable "azure-tenant-id" {
  type        = string
  description = "Azure Tenant ID"
}

#########################
## Network - Variables ##
#########################

variable "hub-vnet" {
  type        = string
  description = "The CIDR of the VNET"
}

variable "hub-gateway-subnet" {
  type        = string
  description = "The CIDR for the Gateway subnet"
}

variable "hub-resources-subnet" {
  type        = string
  description = "The CIDR for the Gateway subnet"
}


variable "spoke1-vnet" {
  type        = string
  description = "The CIDR of the VNET"
}

variable "spoke1-subnet1" {
  type        = string
  description = "The CIDR for the Gateway subnet"
}

variable "spoke1-subnet2" {
  type        = string
  description = "The CIDR for the Gateway subnet"
}

variable "spoke2-vnet" {
  type        = string
  description = "The CIDR of the VNET"
}

variable "spoke2-subnet1" {
  type        = string
  description = "The CIDR for the Gateway subnet"
}

variable "spoke2-subnet2" {
  type        = string
  description = "The CIDR for the Gateway subnet"
}
