resource "aws_s3_bucket" "aws_bucket" {
  bucket = "${var.bucketname}" //globally shld be unique
  acl    = "private"

  tags = {
    Name        = "aws_bucket"
  }

  versioning {
    enabled = "${var.vers}" //boolean
  }
}
