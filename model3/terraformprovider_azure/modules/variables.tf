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
