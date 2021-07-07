

###############################################
##### Credentials to authenticating Azure
###############################################



variable "clientid" {
  description = "contains the Client Id for service principal"
  default   = "XXXXXXXXXXXXX"
}

variable "clientsecret" {
  description = "contains the Client Secret for service principal"
  default   = "XXXXXXXXXXXXXXXX"
}

variable "tenantid" {
  description = "contains the Tenant Id for service principal"
  default   = "XXXXXXXXXXXXXXXX"
}

variable "subscriptionid" {
  description = "contains the Subscription Id for service principal"
  default   = "XXXXXXXXXXXXXXXX"
}

variable "resource_group_name" {
  description = "contains the name of the Resource Group"
  default     = "spoke1-rg"
}

variable "resource_group_location" {
  description = "contains the location of Resource Group"
  default     = "eastus"
}


###############################################
### AKS ###
###############################################



variable "cluster_name" {
  description = "This Contains the name of Azure Container Registry"
  default     = "akscluster"
}

variable "kube_version" {
  default = "1.19.10" 
}

variable "node_count" {
  default = "3"
}

variable "node_size" {
  default = "Standard_D2_v2"
}  

variable "node_disk_size" {
  default = "40"
}

variable "node_pod_count"
  default = "30"
}

variable "network_plugin" {
  description = "Kubernetes networking plugin"
  default     = "kubenet"
}



