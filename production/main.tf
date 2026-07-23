module "vpc" {
  source      = "../modules/vpc"
  vpc_cidr    = var.vpc_cidr
  environment = var.environment

}

module "db_secret" {
  source      = "../modules/secrets"
  environment = var.environment
}

module "postgres" {
  source             = "../modules/postgres"
  environment        = var.environment
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  cidr_blocks        = module.vpc.vpc_cidr_block
  username           = module.db_secret.username
  password           = module.db_secret.password
  bastion_cidr       = var.bastion_cidr
}

module "eks" {
  source             = "../modules/eks"
  environment        = var.environment
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  vpc_cidr           = var.vpc_cidr
  bastion_cidr       = var.bastion_cidr
}

module "ecr" {
  source           = "../modules/ecr"
  repository_names = var.repository_names
  environment      = var.environment
  account_id       = var.account_id
}