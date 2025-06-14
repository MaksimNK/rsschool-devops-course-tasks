provider "aws" {
    region = var.aws_region
}

resource "aws_s3_bucket" "terraform_bucket_2025_rs" {
    bucket = "terraform-bucket-2025-rs-${random_id.bucket_id.hex}"
    force_destroy = true
}

resource "random_id" "bucket_id" {
  byte_length = 4
}
