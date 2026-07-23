locals {
  name     = "cloudcart-bastion"
  vpc_cidr = var.vpc_cidr
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)

  # Tooling is baked into the AMI (see packer/). Keep first-boot config minimal.
  user_data = <<-EOT
  #!/bin/bash
  set -x
  systemctl enable --now amazon-ssm-agent
  EOT

  tags = {
    Name = local.name
  }
}
