module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name                    = "${local.name}-${var.environment}"
  cluster_version                 = local.cluster_version
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = false


  enable_cluster_creator_admin_permissions = false
  authentication_mode                      = local.authentication_mode

  cluster_addons = {
    kube-proxy = {
      most_recent = true
    }
    coredns = {
      most_recent = true
    }
    vpc-cni = {
      most_recent              = true
      before_compute           = true
      service_account_role_arn = module.vpc_cni_irsa.iam_role_arn
      configuration_values = jsonencode({
        env = {
          ENABLE_PREFIX_DELEGATION = "true"
          WARM_PREFIX_TARGET       = "1"
        }
      })
    }
  }


  vpc_id                   = var.vpc_id
  subnet_ids               = var.private_subnet_ids
  control_plane_subnet_ids = var.private_subnet_ids

  # Extend node-to-node security group rules
  node_security_group_additional_rules = {
    ingress_self_all = {
      description = "Node to node all ports/protocols"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "ingress"
      self        = true
    }
    egress_all = {
      description = "Node all egress"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "egress"
      cidr_blocks = ["0.0.0.0/0"]
    }

  }
  ## Allow API access from the shared bastion VPC (reached over VPC peering)
  cluster_security_group_additional_rules = {
    ingress_bastion = {
      description = "Allow API access from shared bastion VPC"
      type        = "ingress"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = [var.bastion_cidr]
    }
  }

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    ami_type                   = local.ami_type
    instance_types             = [local.instance_size]
    iam_role_attach_cni_policy = true
  }

  eks_managed_node_groups = {
    "${var.environment}-node-wg-1" = {
      min_size      = local.min_size
      max_size      = local.max_size
      desired_size  = local.desired_size
      capacity_type = local.capacity_type
    }

    "${var.environment}-node-wg-2" = {
      min_size      = local.min_size
      max_size      = local.max_size
      desired_size  = local.desired_size
      capacity_type = local.capacity_type
    }
  }

  # Optional in-module access entry. The shared/hub config manages the
  # bastion's access entries out-of-band, so this stays empty unless an
  # explicit role ARN is supplied.
  access_entries = var.iam_role_arn != "" ? {
    devops = {
      principal_arn = var.iam_role_arn
      policy_associations = {
        create = {
          policy_arn = local.policy_arn
          access_scope = {
            namespaces = []
            type       = local.type
          }
        }
      }
    }
  } : {}

  tags = local.tags

}

module "vpc_cni_irsa" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.0"

  role_name_prefix      = local.role_name_prefix
  attach_vpc_cni_policy = true
  vpc_cni_enable_ipv4   = true

  oidc_providers = {
    main = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:aws-node"]
    }
  }
}
