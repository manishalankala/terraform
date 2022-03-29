resource "aws_instance" "EC2-dev" {
    ami = var.amidev
    instance_type = "t2.micro"
    tags = {
        Name = "EC2-dev"
    }
}
resource "aws_instance" "EC2-prod" {
    ami = var.ami
    instance_type = "t2.micro"
    tags = {
        Name = "EC2-prod"
    }
   provider = aws.prod
}
