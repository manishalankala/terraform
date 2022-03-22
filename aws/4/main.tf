
#### Provider

terraform {
  backend "s3" {}
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.63.0"
    }
  }
}

provider "aws" {
  region = var.region
  default_tags {
    tags = {
      Environment = var.environment
      Team        = var.team
      Application = var.project
      Platform    = var.platform
      Terraform   = "true"
    }
  }
}

## Locals

locals {
  app_definitions = merge(
    {
      "test-env" = "value",
  })
}


module "ecs-fargate-service" {
  depends_on              = [module.vpc]
  source                  = "./modules/ecs-fargate-service"
  vpc_id                  = var.vpc_id
  environment             = var.environment
  project                 = var.project
  region                  = var.region
  app_definitions         = local.app_definitions
  health_check_path       = "/LoginWebApp-1/"
 }
