module "role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "~> 5.0"

  # Bastion is an EC2 instance; only EC2 needs to assume this role.
  trusted_role_services = ["ec2.amazonaws.com"]

  create_role             = true
  create_instance_profile = true
  role_name               = local.role_name
  role_requires_mfa       = false

  # No attached policies here. The bastion's permissions are granted by the
  # shared config: AmazonSSMManagedInstanceCore + a scoped bastion-ops inline
  # policy, plus per-cluster EKS access entries. The EKS *cluster*/*worker*
  # managed policies were removed — they belong on cluster/node roles, not a
  # jump host.
  number_of_custom_role_policy_arns = 0
}
