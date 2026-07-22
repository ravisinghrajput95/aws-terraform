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

variable "ssh_ingress_cidrs" {
  description = "CIDRs allowed to SSH into the bastion. Defaults to [] (SSM Session Manager only, no inbound). Set to your admin CIDR(s) only if you also want SSH — note the private bastion has no public IP, so SSH would require in-VPC/peered access."
  type        = list(string)
  default     = []
}
