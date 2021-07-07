

###############################################
##### Credentials to authenticating Azure
###############################################



variable "clientid" {
  description = "contains the Client Id for service principal"
  default   = "XXX"
}

variable "clientsecret" {
  description = "contains the Client Secret for service principal"
  default   = "XXX"
}

variable "tenantid" {
  description = "contains the Tenant Id for service principal"
  default   = "XXX"
}

variable "subscriptionid" {
  description = "contains the Subscription Id for service principal"
  default   = "XXX"
}




variable "resource_group_name" {
  description = "contains the name of the Resource Group"
  default     = "spoke1-rg"
}

variable "resource_group_location" {
  description = "contains the location of Resource Group"
  default     = "eastus"
}

variable "cluster_name" {
  description = "This Contains the name of Azure Container Registry"
  default     = "akscluster"
}


variable "vm_size" {
  default = "Standard_D2_v2"
}  

variable "kube_version" {
  default = "1.19.10" 
}

node_count
ode_disk_size
