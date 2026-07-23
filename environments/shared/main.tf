########################################
# Shared/hub VPC + bastion
########################################
module "kms" {
  source             = "../../modules/security/kms"
  alias              = "cloudcart-shared-logs"
  description        = "CloudCart shared log encryption (flow logs, SSM session logs)"
  service_principals = ["logs.${var.aws_region}.amazonaws.com"]
}

module "vpc" {
  source               = "../../modules/networking/vpc"
  environment          = "shared"
  vpc_cidr             = var.vpc_cidr
  subnet_newbits       = 2              # /24 -> /26 subnets
  enable_nat_gateway   = var.enable_nat # default false: bastion reaches AWS via VPC endpoints
  flow_log_kms_key_arn = module.kms.key_arn
}

module "sg" {
  source            = "../../modules/networking/sg"
  vpc_id            = module.vpc.vpc_id
  ssh_ingress_cidrs = var.ssh_ingress_cidrs
}

module "role" {
  source = "../../modules/security/role"
}

module "bastion" {
  source     = "../../modules/compute/bastion"
  vpc_cidr   = var.vpc_cidr
  subnet_ids = module.vpc.private_subnet_ids # private subnet: no public IP, SSM-only
  ami_id     = var.bastion_ami_id            # empty => latest Packer-built cloudcart-bastion-* AMI
  # associate_public_ip / create_eip / key_name default off (SSM-only)
  security_group_id = module.sg.security_group_id
  iam_role_name     = module.role.iam_role_name
}

########################################
# Peering: hub <-> each environment
########################################
module "peering" {
  source   = "../../modules/networking/peering"
  for_each = local.spokes

  name                      = "cloudcart-shared-to-${each.key}"
  requester_vpc_id          = module.vpc.vpc_id
  requester_cidr            = var.vpc_cidr
  requester_route_table_ids = concat(module.vpc.private_route_table_ids, module.vpc.public_route_table_ids)
  accepter_vpc_id           = each.value.vpc_id
  accepter_cidr             = each.value.cidr
  accepter_route_table_ids  = each.value.route_table_ids

  tags = { Application = "cloudcart" }
}

########################################
# Bastion access to each EKS cluster
########################################
resource "aws_eks_access_entry" "bastion" {
  for_each      = local.spokes
  cluster_name  = each.value.cluster_name
  principal_arn = module.role.iam_role_arn
  type          = "STANDARD"
}

resource "aws_eks_access_policy_association" "bastion" {
  for_each      = local.spokes
  cluster_name  = each.value.cluster_name
  principal_arn = module.role.iam_role_arn
  policy_arn    = var.bastion_eks_access_policy_arn

  access_scope {
    type = "cluster"
  }

  depends_on = [aws_eks_access_entry.bastion]
}

########################################
# SSM Session Manager access to the bastion
########################################
resource "aws_iam_role_policy_attachment" "bastion_ssm" {
  role       = module.role.iam_role_name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

########################################
# Bastion IAM permissions for EKS + RDS + Secrets ops
########################################
resource "aws_iam_role_policy" "bastion_ops" {
  name = "cloudcart-bastion-ops"
  role = module.role.iam_role_name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid      = "EksDescribe"
        Effect   = "Allow"
        Action   = ["eks:DescribeCluster", "eks:ListClusters"]
        Resource = "*"
      },
      {
        Sid      = "RdsDescribe"
        Effect   = "Allow"
        Action   = ["rds:DescribeDBInstances", "rds:DescribeDBClusters"]
        Resource = "*"
      },
      {
        Sid      = "ReadDbSecrets"
        Effect   = "Allow"
        Action   = ["secretsmanager:GetSecretValue", "secretsmanager:DescribeSecret"]
        Resource = "arn:aws:secretsmanager:*:*:secret:cloudcart-*-db-password*"
      },
      {
        Sid      = "SessionLogs"
        Effect   = "Allow"
        Action   = ["logs:CreateLogStream", "logs:PutLogEvents", "logs:DescribeLogStreams", "logs:DescribeLogGroups"]
        Resource = "${aws_cloudwatch_log_group.ssm_sessions.arn}:*"
      },
    ]
  })
}
