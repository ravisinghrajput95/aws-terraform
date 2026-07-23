# Bootstrap: creates the S3 state buckets that every other configuration uses
# as its backend. Uses a LOCAL backend (this is the chicken-and-egg breaker),
# so run this once, first. Locking for all envs is S3-native (use_lockfile),
# so there are no DynamoDB tables to create.

terraform {
  required_version = ">= 1.10"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  # Intentionally no backend block -> local state.
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = "bootstrap"
      Application = "cloudcart"
      ManagedBy   = "terraform"
      Repository  = "aws-terraform"
    }
  }
}

module "kms_state" {
  source      = "../modules/security/kms"
  alias       = "cloudcart-terraform-state"
  description = "CloudCart Terraform state bucket encryption"
}

module "state_bucket" {
  source   = "../modules/storage/tf-backend"
  for_each = toset(var.state_buckets)

  bucket_name = each.value
  kms_key_arn = module.kms_state.key_arn
  tags = {
    Application = "cloudcart"
    Purpose     = "terraform-state"
    ManagedBy   = "terraform"
  }
}
