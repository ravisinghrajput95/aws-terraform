terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "cloudcart-terraform-backend"
    key            = "qa/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "cloudcart-terraform"
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region
}
