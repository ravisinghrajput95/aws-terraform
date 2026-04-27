terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "accord-terraform-production-state"
    key            = "production/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "finops-eks-terraform-backend"
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region
}
