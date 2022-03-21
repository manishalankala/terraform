#VPC
resource "aws_vpc" "vpc_name" {
  cidr_block           = "${var.vpc_cidr_block}"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"

  tags {
    Name = "${var.vpc_name}"
  }
}

data "aws_availability_zones" "available" {}

#Public Subnet
resource "aws_subnet" "vpc_public_sn_1" {
  vpc_id            = "${aws_vpc.vpc_name.id}"
  cidr_block        = "${var.vpc_public_subnet_1_cidr}"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  map_public_ip_on_launch = "true"
  tags {
    Name = "${var.vpc_name}_vpc_public_sn_1"
  }
}

#Private subnet 
resource "aws_subnet" "vpc_private_sn_1" {
  vpc_id            = "${aws_vpc.vpc_name.id}"
  cidr_block        = "${var.vpc_private_subnet_1_cidr}"
  availability_zone = "${data.aws_availability_zones.available.names[1]}"
  map_public_ip_on_launch = "false"

  tags {
    Name = "${var.vpc_name}_vpc_private_sn_1"
  }
}

#Internet gateway
resource "aws_internet_gateway" "vpc_ig" {
  vpc_id = "${aws_vpc.vpc_name.id}"

  tags {
    Name = "${var.vpc_name}_ig"
  }
}


#nat gw
resource "aws_eip" "nat" {
  vpc = true

  tags {
    Name = "${var.vpc_name}_nat_eip"
  }
}

resource "aws_nat_gateway" "vpc_nat" {
  allocation_id = "${aws_eip.nat.id}"
  subnet_id     = "${aws_subnet.vpc_public_sn_1.id}"
  depends_on    = ["aws_internet_gateway.vpc_ig"]

  tags {
    Name = "${var.vpc_name}_nat"
  }
}

# Routing table for public subnet
resource "aws_route_table" "vpc_public_sn_rt" {
  vpc_id = "${aws_vpc.vpc_name.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.vpc_ig.id}"
  }

  tags {
    Name = "vpc_public_sn_rt"
  }
}

# Routing table for private subnet

resource "aws_route_table" "vpc_private_sn_rt" {
  vpc_id = "${aws_vpc.vpc_name.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_nat_gateway.vpc_nat.id}"
  }

  tags {
    Name = "vpc_private_sn_rt"
  }
}

# Associate the routing table to public subnet

resource "aws_route_table_association" "vpc_public_sn_rt_assn" {
  subnet_id      = "${aws_subnet.vpc_public_sn_1.id}"
  route_table_id = "${aws_route_table.vpc_public_sn_rt.id}"
}

# Associate the routing table to private subnet

resource "aws_route_table_association" "vpc_private_sn_rt_assn" {
  subnet_id      = "${aws_subnet.vpc_private_sn_1.id}"
  route_table_id = "${aws_route_table.vpc_private_sn_rt.id}"
}
