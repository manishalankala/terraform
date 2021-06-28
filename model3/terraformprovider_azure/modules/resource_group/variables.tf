variable "global_settings" {
  description = "Global settings object"
}

variable "tags" {
  description = "(Required) Map of tags to be applied to the resource"
  type        = map(any)
}


variable "environment" {
  type        = string
  description = "environment the resources are supporting (ex. dev, stg, prod, ...)"
}

variable "environment_map" {
  type = map  
  default = {
    dev     = “dev”
    test    = “test”
    preprod = “preprod”
    prod    = “prod”
  }
}


variable "settings" {}

variable "resource_group_name" {
  description = "The name of the resource group where to create the resource."
  type        = string
}



locals {
  name-prefix = "${var.project_name}-${var.environment}"
  envdev = DEV
  envtest = TEST
  envpreprod = PREPROD
  envprod = PROD
  
}
