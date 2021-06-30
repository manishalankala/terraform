#### 1. resource

variable "resource_group_name" {
  type   = string
}

##### 2. Location

variable "location" {
  type   = string
}

#### 3. tags

variable "tags" {
  type        = map(any)
}

#### 4. environment

variable "environment" {
  type        = string
}










#locals {
#  name-prefix = "${var.project_name}-${var.environment}"
#  envdev = DEV
#  envtest = TEST
#  envpreprod = PREPROD
#  envprod = PROD
  
#}
