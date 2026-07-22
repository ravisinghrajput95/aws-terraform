output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnets
}

output "private_subnet_ids" {
  value = module.vpc.private_subnets
}

output "public_route_table_ids" {
  value = module.vpc.public_route_table_ids
}

output "private_route_table_ids" {
  value = module.vpc.private_route_table_ids
}

output "vpc_arn" {
  value = module.vpc.vpc_arn
}

output "vpc_cidr_block" {
  value = module.vpc.vpc_cidr_block
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "public_subnet_arns" {
  value = module.vpc.public_subnet_arns
}

output "public_subnets_cidr_blocks" {
  value = module.vpc.public_subnets_cidr_blocks
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

output "private_subnet_arns" {
  value = module.vpc.private_subnet_arns
}

output "private_subnets_cidr_blocks" {
  value = module.vpc.private_subnets_cidr_blocks
}

output "db_instance_address" {
  description = "The address of the RDS instance"
  value       = module.postgres.db_instance_address
}

output "db_instance_arn" {
  description = "The ARN of the RDS instance"
  value       = module.postgres.db_instance_arn
}

output "db_instance_availability_zone" {
  description = "The availability zone of the RDS instance"
  value       = module.postgres.db_instance_availability_zone
}

output "db_instance_endpoint" {
  description = "The connection endpoint"
  value       = module.postgres.db_instance_endpoint
}

output "kubeconfig" {
  description = "Kubeconfig file for accessing the EKS cluster"
  value       = <<-EOF
    apiVersion: v1
    clusters:
    - cluster:
        server: "https://${module.eks.cluster_endpoint}"
        certificate-authority-data: "${module.eks.cluster_certificate_authority_data}"
      name: "${local.name}-${var.environment}"
    contexts:
    - context:
        cluster: "${local.name}-${var.environment}"
        user: "${local.name}-${var.environment}"
      name: "${local.name}-${var.environment}"
    current-context: "${local.name}-${var.environment}"
    kind: Config
    preferences: {}
    users:
    - name: "${local.name}-${var.environment}"
      user:
        exec:
          apiVersion: client.authentication.k8s.io/v1alpha1
          args:
          - "token"
          - "-i"
          - "${local.name}-${var.environment}"
          command: "aws"
          env: null
    EOF
}

output "bastion_complete_id" {
  description = "The ID of the instance"
  value       = module.bastion.bastion_complete_id
}

output "bastion_complete_arn" {
  description = "The ARN of the instance"
  value       = module.bastion.bastion_complete_arn
}

output "bastion_complete_public_ip" {
  description = "The public IP address assigned to the instance, if applicable. NOTE: If you are using an aws_eip with your instance, you should refer to the EIP's address directly and not use `public_ip` as this field will change after the EIP is attached"
  value       = module.bastion.bastion_complete_public_ip
}

output "bastion_complete_root_block_device" {
  description = "Root block device information"
  value       = module.bastion.bastion_complete_root_block_device
}

output "bastion_complete_ebs_block_device" {
  description = "EBS block device information"
  value       = module.bastion.bastion_complete_ebs_block_device
}

output "security_group_id" {
  value = module.sg.security_group_id
}

output "security_group_arn" {
  value = module.sg.security_group_arn
}

output "iam_role_arn" {
  value = module.role.iam_role_arn
}

output "iam_role_name" {
  value = module.role.iam_role_name
}

output "dev_ecr_repository_arns" {
  description = "ARNs of the created ECR repositories in the dev module"
  value       = module.ecr.ecr_repository_arns
}

output "dev_ecr_pull_policy_arn" {
  description = "ARN of the IAM policy for ECR pull actions in the dev module"
  value       = module.ecr.ecr_pull_policy_arn
}

output "dev_ecr_push_policy_arn" {
  description = "ARN of the IAM policy for ECR push actions in the dev module"
  value       = module.ecr.ecr_push_policy_arn
}

output "dev_ecr_pull_group_name" {
  description = "Name of the IAM group for pull-only access to ECR in the dev module"
  value       = module.ecr.ecr_pull_group_name
}

output "dev_ecr_push_pull_group_name" {
  description = "Name of the IAM group for push and pull access to ECR in the dev module"
  value       = module.ecr.ecr_push_pull_group_name
}

output "dev_ecr_pull_group_users" {
  description = "Users assigned to the pull-only group for ECR in the dev module"
  value       = module.ecr.ecr_pull_group_users
}

output "dev_ecr_push_pull_group_users" {
  description = "Users assigned to the push and pull group for ECR in the dev module"
  value       = module.ecr.ecr_push_pull_group_users
}

output "db_secret_arn" {
  description = "ARN of the Secrets Manager secret holding the DB credentials"
  value       = module.db_secret.secret_arn
}

output "db_secret_name" {
  description = "Name of the Secrets Manager secret holding the DB credentials"
  value       = module.db_secret.secret_name
}
