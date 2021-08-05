provider "aws" {
  profile = "terraform"           # this the profile which we created using aws configure cli command
  region  = "us-east-1"        # this will make default region as ap-south-1 which is in mumbai
}


# this is default vpc in aws ,
# this niether be created during terraform apply and nor be destroyed during terraform destroy
# this the just for referncing attribute of default vpc

resource "aws_default_vpc" "default_vpc" {
  tags = {
    Name = "Default VPC"
  }
}


########################################
### KEY ####
########################################

# this will create a key with RSA algorithm with 4096 rsa bits
resource "tls_private_key" "private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# this resource will create a key pair using above private key
resource "aws_key_pair" "key_pair" {
  key_name   = var.key_name
  public_key = tls_private_key.private_key.public_key_openssh

   depends_on = [tls_private_key.private_key]
}

# this resource will save the private key at our specified path.
resource "local_file" "saveKey" {
  content = tls_private_key.private_key.private_key_pem
  filename = "${var.base_path}${var.key_name}.pem"
  
}

########################################
########## Security group ############
########################################


# this resource will create new security with specified inbound and outbound rules
resource "aws_security_group" "security_group" {
  name        = "allow_tcp"
  description = "Allow tcp inbound traffic"
  vpc_id      = aws_default_vpc.default_vpc.id            # here we are using default vpc attribute id,
                                                          # which we created before for attribute referancing 
  
# creating inbound rule for tcp port 8080 to use jenkins
  ingress {
    description = "Allow Jenkins"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
# creating inbound rule for tcp port 443 to allow https traffic
  ingress {
    description = "Allow HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
# creating inbound rule for tcp port 80 to allow http traffic
  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
# creating inbound rule for tcp port 22 to ssh into instance
  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
# outbound rule protocal -1 means all and port 0 means all
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tcp"
  }
}

######################
#### Ec2 #########
######################

resource "aws_instance" "ec2_instance" {
  ami                    = "ami-0447a12f28fddb066"            # this is a amazon linux ami id
  instance_type          = "t2.micro"
  key_name               = var.key_name
  security_groups = [aws_security_group.security_group.name]
  tags = {
    Name = "webServer"
  }
}


######################
##### EBS #####
######################


# this resource will create a ebs volume with 1 gb in size,
# we are creating this volume for persistant storage of critical data
resource "aws_ebs_volume" "ebs_volume" {
  availability_zone = aws_instance.ec2_instance.availability_zone
  size              = 1
  tags = {
    Name = "ebsVolume"
  }
}

# this will attach above created volume to ec2 instance at /dev/sdf
resource "aws_volume_attachment" "attach_volume" {
  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.ebs_volume.id
  instance_id = aws_instance.ec2_instance.id
  # !! warning
  # dont use force detach and preserve this volume from destroying if using in production or,
  # if it contain important data
  # else you will loose your data
  force_detach = true                           
}



########################
##### S3 Bucket ######
########################


# this resource will create a s3 bucket with name kr-webserver-static
# this bucket will contain all our website static files
resource "aws_s3_bucket" "s3_bucket" {
  bucket = "kr-webserver-static"
  acl    = "private"

  tags = {
    Name = "static files bucket"
  }
}

# here we are blocking all the public access to this bucket,
# we are blocking public access so no can directly access object of bucket,
# we want object to be accesed via cloudFront distribution
resource "aws_s3_bucket_public_access_block" "s3_block_access" {
  bucket = aws_s3_bucket.s3_bucket.id
  block_public_acls   = true
  block_public_policy = true
  restrict_public_buckets = true
  ignore_public_acls = true
}

# this will create a s3 origin id which will be used in cloudFront to set origin as s3 bucket 
locals {
  s3_origin_id = "s3Origin"
}


###########################
##### Cloudfront ########
###########################



# origin access identity for distribution
resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
comment = "cloudfront distribution identity"
}

# distribution
resource "aws_cloudfront_distribution" "distribution" {
  origin {
    # this is the domain name of s3 bucket which we created
    domain_name = aws_s3_bucket.s3_bucket.bucket_regional_domain_name
    # here we are using that s3 origin id 
    origin_id   = local.s3_origin_id

    s3_origin_config {
  origin_access_identity = aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "cloudfront for static content"


  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
    # here we are defining to redirect http trafic to https
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  # we are defining geo_restriction as none 
  # this is a very useful attribute,it can be use when we have to block content on certain geo graphical region
  # we can blacklist or whitelist locations
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

#########################
##### update s3 ######
#########################


# this create s3 policy to allow distribution to read objects from bucket 
data "aws_iam_policy_document" "s3_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.s3_bucket.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = ["${aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn}"]
    }
  }

  statement {
    actions   = ["s3:ListBucket"]
    resources = ["${aws_s3_bucket.s3_bucket.arn}"]

    principals {
      type        = "AWS"
      identifiers = ["${aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn}"]
    }
  }
}

# this will update bucket policy for distribution which we created above
resource "aws_s3_bucket_policy" "update_s3_policy" {
  bucket = aws_s3_bucket.s3_bucket.id
  policy = data.aws_iam_policy_document.s3_policy.json
}
