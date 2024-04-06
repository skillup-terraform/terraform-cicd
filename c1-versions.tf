# Terraform Block
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
    backend "s3" {
    bucket = "terra-157673692367"
    key    = "dev/terraform.tfstate"
    region = "ap-south-1"
    dynamodb_table = "terraform-state-lock"
  }
}

# Provider Block
provider "aws" {
  region  = "ap-south-1"
profile = "default"
}
