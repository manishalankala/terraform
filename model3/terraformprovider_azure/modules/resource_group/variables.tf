
## 1. resource
## 2. Location
## 3. tags
## 4. environment


variable "resource_group_name" {
  type   = string
}

variable "location" {
  type   = string
}

variable "tags" {
  type        = map(any)
}

variable "environment" {
  type        = string
  description = "environment the resources are supporting (ex. dev, stg, prod, ...)"
}










#locals {
#  name-prefix = "${var.project_name}-${var.environment}"
#  envdev = DEV
#  envtest = TEST
#  envpreprod = PREPROD
#  envprod = PROD
  
#}
