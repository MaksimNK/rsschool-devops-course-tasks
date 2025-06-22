terraform {
  required_version = ">= 1.6.0"

  backend "s3" {
    bucket         = "terraform-states-2025-rs"
    key            = "global/s3/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}
