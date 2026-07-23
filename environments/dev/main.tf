module "vpc" {
  source      = "../../modules/networking/vpc"
  environment = var.environment
  vpc_cidr    = var.vpc_cidr
}

module "db_secret" {
  source      = "../../modules/security/secrets"
  environment = var.environment
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
}

module "eks" {
  source             = "../../modules/compute/eks"
  environment        = var.environment
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  vpc_cidr           = var.vpc_cidr
  bastion_cidr       = var.bastion_cidr
}

module "ecr" {
  source           = "../../modules/storage/ecr"
  repository_names = var.repository_names
  environment      = var.environment
}

module "monitoring" {
  source         = "../../modules/observability/monitoring"
  environment    = var.environment
  db_instance_id = module.postgres.db_instance_id
  alarm_email    = var.alarm_email
}
