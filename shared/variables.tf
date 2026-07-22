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
  description = "CIDRs allowed to SSH into the bastion. SSM Session Manager is also available, so SSH is optional — lock this to your admin IP/CIDR, or set [] to disable SSH and use SSM only."
  type        = list(string)
  default     = ["44.226.243.221/32"]
}
