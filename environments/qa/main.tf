module "kms" {
  source             = "../../modules/security/kms"
  alias              = "cloudcart-${var.environment}-data"
  description        = "CloudCart ${var.environment} data encryption (RDS, Secrets, flow logs)"
  service_principals = ["logs.${var.aws_region}.amazonaws.com"]
}

module "vpc" {
  source               = "../../modules/networking/vpc"
  flow_log_kms_key_arn = module.kms.key_arn
  vpc_cidr             = var.vpc_cidr
  environment          = var.environment

}

module "db_secret" {
  source      = "../../modules/security/secrets"
  environment = var.environment
  kms_key_arn = module.kms.key_arn
}

module "postgres" {
  source             = "../../modules/database/postgres"
  environment        = var.environment
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  cidr_blocks        = module.vpc.vpc_cidr_block
  username           = module.db_secret.username
  password           = module.db_secret.password
  bastion_cidr       = var.bastion_cidr
  kms_key_arn        = module.kms.key_arn
}

module "eks" {
  source             = "../../modules/compute/eks"
  environment        = var.environment
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  vpc_cidr           = var.vpc_cidr
  bastion_cidr       = var.bastion_cidr
}

module "monitoring" {
  source         = "../../modules/observability/monitoring"
  environment    = var.environment
  db_instance_id = module.postgres.db_instance_id
  alarm_email    = var.alarm_email
}
