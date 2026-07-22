# With NAT disabled, the private bastion reaches AWS services through VPC
# interface endpoints instead of the internet.
locals {
  interface_endpoints = [
    "ssm", "ssmmessages", "ec2messages", # Session Manager
    "sts",                               # caller identity / EKS token
    "eks",                               # aws eks update-kubeconfig (DescribeCluster)
    "secretsmanager",                    # read DB credentials
    "logs",                              # Session Manager -> CloudWatch logs
    "rds",                               # describe RDS instances
  ]
}

resource "aws_security_group" "vpce" {
  name        = "cloudcart-shared-vpce"
  description = "Allow HTTPS from within the shared VPC to the interface endpoints"
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

resource "aws_vpc_endpoint" "interface" {
  for_each = toset(local.interface_endpoints)

  vpc_id              = module.vpc.vpc_id
  service_name        = "com.amazonaws.${var.aws_region}.${each.value}"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = module.vpc.private_subnet_ids
  security_group_ids  = [aws_security_group.vpce.id]
  private_dns_enabled = true

  tags = { Name = "cloudcart-shared-${each.value}" }
}

# S3 is a free gateway endpoint (used by the AWS CLI, SSM, etc.).
resource "aws_vpc_endpoint" "s3" {
  vpc_id            = module.vpc.vpc_id
  service_name      = "com.amazonaws.${var.aws_region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = module.vpc.private_route_table_ids

  tags = { Name = "cloudcart-shared-s3" }
}
