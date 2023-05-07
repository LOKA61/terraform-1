terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
}
backend "s3" {
    bucket = "kris9161-backend-s3"
    key    = "timing"
    region = "ap-south-1"
    dynamodb_table = "timing-lock"
  }
