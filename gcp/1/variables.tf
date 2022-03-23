#### varaibles ####

variable "name" { 
}
variable "region" {
  default = "us-central1"
}
variable "machine_type" {
  default = "n2-standard-2"
}
variable "node_count" {
  default = 1
  type = number 
}
variable "cluster_name" {}
variable "endpoint" {}
variable "ca_cert" {}
variable "location" {
  default = "us-central1"
}
variable "pod_name" {}
variable "image" {}
