variable "subscription_id" {}
variable "client_id" {}
variable "client_secret" {}
variable "tenant_id" {}
variable "location" {
    default = "West Europe"
}



################################################################################################################

variable "subscription_id" {
  default = ""
}

variable "client_id" {
  default = ""
  type    = ""
}

variable "client_secret" {
  default = ""
  type   = ""
}

variable "key_name" {
  default = ""
  type    = ""
}


variable "tenant_id" {
  default = ""
  type    = ""
}


variable "tag_environment" {
  type = string
}

variable "tag_project" {
  type = string
}







variable "global_settings" {
  description = "Global settings object"
}





locals {
  name-prefix = "${var.project_name}-${var.environment}"
}
