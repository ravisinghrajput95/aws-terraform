module "vpc" {
  source      = "../modules/vpc"
  environment = var.environment
  vpc_cidr    = var.vpc_cidr
}

module "rds" {
  source               = "../modules/rds"
  environment          = var.environment
  vpc_id               = module.vpc.vpc_id
  private_subnet_ids   = module.vpc.private_subnet_ids
  cidr_blocks          = module.vpc.vpc_cidr_block
  private_subnet_names = module.vpc.private_subnets
  password             = var.password

}

module "eks" {
  source                     = "../modules/eks"
  environment                = var.environment
  vpc_id                     = module.vpc.vpc_id
  private_subnet_ids         = module.vpc.private_subnet_ids
  vpc_cidr                   = var.vpc_cidr
  bastion_complete_public_ip = module.bastion.bastion_complete_public_ip
  security_group_id          = module.sg.security_group_id
  iam_role_arn               = module.role.iam_role_arn
}

module "bastion" {
  source            = "../modules/bastion"
  vpc_cidr          = var.vpc_cidr
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  security_group_id = module.sg.security_group_id
  iam_role_name     = module.role.iam_role_name
}

module "sg" {
  source   = "../modules/sg"
  vpc_cidr = var.vpc_cidr
  vpc_id   = module.vpc.vpc_id
}

module "role" {
  source = "../modules/role"
}

module "ecr" {
  source           = "../modules/ecr"
  repository_names = var.repository_names
  environment      = var.environment
  region           = var.region
  account_id       = var.account_id
}