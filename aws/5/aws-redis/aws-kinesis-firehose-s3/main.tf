resource "aws_kinesis_firehose_delivery_stream" "aws_firehose_extended_s3_stream" {
  name        = "firehose-extended-s3-test-stream"
  destination = "extended_s3"

  extended_s3_configuration {
    role_arn   = aws_iam_role.firehose_role.arn
    bucket_arn = aws_s3_bucket.firehose-bucket.arn

    processing_configuration {
      enabled = "false"

      
}
}
}

resource "aws_s3_bucket" "aws-firehose-bucket" {
  bucket = "firehose-bucket-s3"
  acl    = "private"
}

resource "aws_iam_role" "aws_firehose_role" {
  name = "aws_firehose_s3_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "firehose.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
