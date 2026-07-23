# Account-level security & audit services. These are account/region singletons,
# so they live in the shared (management) environment — not per-spoke.

module "guardduty" {
  source = "../modules/guardduty"
}

module "cloudtrail" {
  source      = "../modules/cloudtrail"
  name        = "cloudcart-trail"
  bucket_name = var.cloudtrail_bucket_name
}

module "aws_config" {
  source      = "../modules/config"
  name        = "cloudcart-config"
  bucket_name = var.config_bucket_name
}

module "security_hub" {
  source = "../modules/securityhub"
}

module "access_analyzer" {
  source = "../modules/access-analyzer"
}
