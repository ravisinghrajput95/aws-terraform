########################################
# Shared/hub VPC + bastion
########################################
module "vpc" {
  source         = "../modules/vpc"
  environment    = "shared"
  vpc_cidr       = var.vpc_cidr
  subnet_newbits = 2 # /24 -> /26 subnets
}

module "sg" {
  source   = "../modules/sg"
  vpc_cidr = var.vpc_cidr
  vpc_id   = module.vpc.vpc_id
}

module "role" {
  source = "../modules/role"
}

module "bastion" {
  source            = "../modules/bastion"
  vpc_cidr          = var.vpc_cidr
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  security_group_id = module.sg.security_group_id
  iam_role_name     = module.role.iam_role_name
}

########################################
# Peering: hub <-> each environment
########################################
module "peering" {
  source   = "../modules/peering"
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
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  access_scope {
    type = "cluster"
  }

  depends_on = [aws_eks_access_entry.bastion]
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
    ]
  })
}
