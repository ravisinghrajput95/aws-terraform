locals {
  name                = "cloudcart-bastion-eks"
  ingress_cidr_blocks = ["44.226.243.221/32"]
  ingress_rules       = ["ssh-tcp"]
  egress_rules        = ["all-all"]
  description         = "Security group for SSH access to bastion host"
  tags = {
    name = local.name
  }
}