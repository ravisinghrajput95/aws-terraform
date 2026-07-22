# SSM interface endpoints so Session Manager reaches a private, no-public-IP
# bastion over the AWS backbone (no internet path required for the control channel).
resource "aws_security_group" "vpce" {
  name        = "cloudcart-shared-vpce"
  description = "Allow HTTPS from within the shared VPC to the SSM interface endpoints"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "HTTPS from within the shared VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "cloudcart-shared-vpce" }
}

resource "aws_vpc_endpoint" "ssm" {
  for_each = toset(["ssm", "ssmmessages", "ec2messages"])

  vpc_id              = module.vpc.vpc_id
  service_name        = "com.amazonaws.${var.aws_region}.${each.value}"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = module.vpc.private_subnet_ids
  security_group_ids  = [aws_security_group.vpce.id]
  private_dns_enabled = true

  tags = { Name = "cloudcart-shared-${each.value}" }
}
