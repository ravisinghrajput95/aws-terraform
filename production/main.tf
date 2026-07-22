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
  source               = "../modules/postgres"
  environment          = var.environment
  vpc_id               = module.vpc.vpc_id
  private_subnet_ids   = module.vpc.private_subnet_ids
  cidr_blocks          = module.vpc.vpc_cidr_block
  private_subnet_names = module.vpc.private_subnets
  username             = module.db_secret.username
  password             = module.db_secret.password
}

module "eks" {
  source                     = "../modules/eks"
  environment                = var.environment
  vpc_id                     = module.vpc.vpc_id
  private_subnet_ids         = module.vpc.private_subnet_ids
  vpc_cidr                   = var.vpc_cidr
  bastion_complete_public_ip = data.terraform_remote_state.dev.outputs.bastion_complete_public_ip
  security_group_id          = data.terraform_remote_state.dev.outputs.security_group_id
}

module "ecr" {
  source           = "../modules/ecr"
  repository_names = var.repository_names
  environment      = var.environment
  region           = var.region
  account_id       = var.account_id
}