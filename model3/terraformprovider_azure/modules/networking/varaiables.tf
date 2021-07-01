variable "resource_group_name" {
  type        = string
}

variable "location" {
  type        = string
}


variable "prefix" {
  type        = string
}


variable "custom_vnet_name" {
  type        = string
  default     = ""
}


variable "address_space" {
  type        = list(string)
}

variable "dns_servers" {
  type        = list(string)
  default     = ["10.0.0.4", "10.0.0.5", "8.8.8.8", "1.1.1.1"]
}

variable "vnet_address_space" {
  type        = string
  default     = ["10.0.0.0/16"]
  
  
variable "vnet_cidr" {
  type        = list(string)
}  
  
variable "create_ddos_plan" {
  type        = bool  
  default     = false
}  

variable "environment" {
  type        = string
}
