locals {
    tag_name = var.bucket_name
}

resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name

  tags = {
    Name        =  local.tag_name
    Environment = "Dev"
  }
}