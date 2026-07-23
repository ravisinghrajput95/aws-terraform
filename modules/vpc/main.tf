module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.7.1"

  name = format("cloudcart-%s-vpc", var.environment)
  cidr = var.vpc_cidr
  azs  = local.azs

  enable_nat_gateway   = var.enable_nat_gateway
  single_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true

  private_subnet_names = [for idx in range(local.private_subnet_count) : "${var.environment}-private-${idx + 1}"]
  public_subnet_names  = [for idx in range(local.public_subnet_count) : "${var.environment}-public-${idx + 1}"]

  private_subnets = [for idx in range(local.private_subnet_count) : cidrsubnet(var.vpc_cidr, var.subnet_newbits, idx)]
  public_subnets  = [for idx in range(local.public_subnet_count) : cidrsubnet(var.vpc_cidr, var.subnet_newbits, idx + local.private_subnet_count)]

  manage_default_network_acl    = false
  manage_default_route_table    = false
  manage_default_security_group = false

  # VPC Flow Logs -> CloudWatch
  enable_flow_log                                 = var.enable_flow_logs
  create_flow_log_cloudwatch_log_group            = var.enable_flow_logs
  create_flow_log_cloudwatch_iam_role             = var.enable_flow_logs
  flow_log_max_aggregation_interval               = 60
  flow_log_cloudwatch_log_group_retention_in_days = var.flow_log_retention_days

  tags = local.tags
}
