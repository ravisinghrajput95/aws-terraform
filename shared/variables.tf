variable "aws_region" {
  description = "AWS region where the shared/hub resources live"
  type        = string
  default     = "us-west-2"
}

variable "vpc_cidr" {
  description = "CIDR block for the shared bastion VPC (kept short — a /24 is plenty for a bastion)"
  type        = string
  default     = "172.31.0.0/24"
}
