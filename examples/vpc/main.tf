# Example: minimal VPC using the networking VPC module.
# Run: terraform init && terraform plan

terraform {
  required_version = ">= 1.10"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

module "vpc" {
  source      = "../../modules/networking/vpc"
  environment = "dev"
  vpc_cidr    = "10.0.0.0/16"

  # Optional overrides:
  # single_nat_gateway = false   # per-AZ NAT (HA)
  # enable_flow_logs   = true
}

output "vpc_id" {
  value = module.vpc.vpc_id
}
