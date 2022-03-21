#aws credetials for aws 
variable "aws_access_key_id" {
  description = "AWS access key"
}

variable "aws_secret_access_key" {
  description = "AWS secret access  key"
}

variable "availability_zone" {
  description = "Availabilty zone based on region"

  default = {
    us-east-1 = "us-east-1a"
    us-west-1 = "us-west-1a"
  }
}

# vpc config 
variable "vpc_name" {
  description = "vpc for buiding a vpc"
}

variable "vpc_region" {
  description = "AWS VPC region"
}

variable "vpc_cidr_block" {
  description = "CIDR block for vpc"
}

variable "vpc_public_subnet_1_cidr" {
  description = "CIDR for public subnet"
}

#variable "vpc_access_from_ip_range" {
#  description = "Access can be made from the following IPs"
#}

variable "vpc_private_subnet_1_cidr" {
  description = "Private CIDR for internally accessible subnet"
}
