module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name                    = "${local.name}-${var.environment}"
  cluster_version                 = local.cluster_version
  cluster_endpoint_private_access = true


  enable_cluster_creator_admin_permissions = false
  authentication_mode                      = local.authentication_mode

  cluster_endpoint_public_access_cidrs = ["${var.bastion_complete_public_ip}/32"]

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
  ## Enable access from bastion host to EKS endpoint
  cluster_security_group_additional_rules = {
    ingress_bastion = {
      description              = "Allow access from Bastion Host"
      type                     = "ingress"
      from_port                = 443
      to_port                  = 443
      protocol                 = "tcp"
      source_security_group_id = var.security_group_id
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

  access_entries = {
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
  }

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
