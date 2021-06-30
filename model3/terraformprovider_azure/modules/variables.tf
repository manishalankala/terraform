variable "subscription_id" {}
variable "client_id" {}
variable "client_secret" {}
variable "tenant_id" {}
variable "location" {
    default = "West Europe"
}


variable "subscription_id" {
  default = ""
}

variable "client_id" {
  default = ""
}

variable "client_secret" {
  default = ""
}

variable "key_name" {
}


variable "tenant_id" {
  default = ""
}


variable "global_settings" {
  description = "Global settings object"
}

variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

locals {
  name-prefix = "${var.project_name}-${var.environment}"
}
