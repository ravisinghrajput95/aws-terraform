locals {
  name                = "cloudcart-bastion-eks"
  ingress_cidr_blocks = var.ssh_ingress_cidrs
  ingress_rules       = length(var.ssh_ingress_cidrs) > 0 ? ["ssh-tcp"] : []
  egress_rules        = ["all-all"]
  description         = "Security group for SSH access to bastion host"
  tags = {
    name = local.name
  }
}