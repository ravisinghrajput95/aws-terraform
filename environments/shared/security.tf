# Account-level security & audit services. These are account/region singletons,
# so they live in the shared (management) environment — not per-spoke.

module "guardduty" {
  source = "../../modules/security/guardduty"
}

module "cloudtrail" {
  source      = "../../modules/security/cloudtrail"
  name        = "cloudcart-trail"
  bucket_name = var.cloudtrail_bucket_name
}

module "aws_config" {
  source      = "../../modules/security/config"
  name        = "cloudcart-config"
  bucket_name = var.config_bucket_name
}

module "security_hub" {
  source = "../../modules/security/securityhub"
}

module "access_analyzer" {
  source = "../../modules/security/access-analyzer"
}
