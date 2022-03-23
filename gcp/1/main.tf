terraform {
  required_version = ">= 1.0.11"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.5.0" 
    }
    kubernetes = {
        source = "hashicorp/kubernetes"
        version = ">= 2.8.0"
    }
  }
  backend "gcs" {
      bucket = ""
      prefix = "terraform/dev"
  }
}
provider "google" {
  project = ""
}

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



resource "google_service_account" "default" {
  account_id   = "service-account-id"
  display_name = "Service Account"
}
resource "google_container_cluster" "cluster" {
  name     = var.name
  location = var.region

  remove_default_node_pool = true
  initial_node_count       = 1
}


resource "google_container_node_pool" "nodes" {
  name       = "${var.name}-nodes"
  location   = var.region
  cluster    = google_container_cluster.cluster.name
  node_count = var.node_count

  node_config {
    preemptible  = true
    machine_type = "g1-small"
    service_account = google_service_account.default.email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}

data "google_client_config" "provider" {}
provider "kubernetes" {
  host  = "https://${var.endpoint}"
  token = data.google_client_config.provider.access_token
  cluster_ca_certificate = base64decode(
    var.ca_cert,
  )
}


resource "kubernetes_pod" "sample_app" {
  metadata {
    name = var.pod_name
  }

  spec {
    container {
      image = "nginx:1.7.9"
      name  = "example"

      env {
        name  = "environment"
        value = "test"
      }

      port {
        container_port = 8080
      }

      liveness_probe {
        http_get {
          path = "/nginx_status"
          port = 80

          http_header {
            name  = "X-Custom-Header"
            value = "Awesome"
          }
        }

        initial_delay_seconds = 3
        period_seconds        = 3
      }
    }

    dns_config {
      nameservers = ["1.1.1.1", "8.8.8.8", "9.9.9.9"]
      searches    = ["example.com"]

      option {
        name  = "ndots"
        value = 1
      }

      option {
        name = "use-vc"
      }
    }

    dns_policy = "None"
  }
}


output "cluster_name" {
  value = google_container_cluster.cluster.name
}
output "endpoint" {
    value = google_container_cluster.cluster.endpoint
}
output "ca_cert" {
  value = google_container_cluster.cluster.master_auth[0].cluster_ca_certificate
}
