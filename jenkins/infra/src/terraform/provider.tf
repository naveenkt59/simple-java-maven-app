provider "aws" {
    assume_role {
    role_arn     = "arn:aws:iam::883089186918:role/ec2_role"
  }
    region = "eu-central-1"
}

terraform {
  backend "s3" {
    bucket = "java-bucket-devps"
    key    = ".terraform/terraform.state"
    region = "eu-central-1"
  }
}
