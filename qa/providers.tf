terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "accord-terraform-backend"
    key            = "qa/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "accord-terraform"
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region
}
