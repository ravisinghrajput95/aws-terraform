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

variable "bastion_eks_access_policy_arn" {
  description = "EKS access-entry policy granted to the bastion on each cluster. Defaults to cluster-admin (ops jump host); scope down (e.g. AmazonEKSEditPolicy/AmazonEKSViewPolicy) for least privilege."
  type        = string
  default     = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
}

variable "enable_nat" {
  description = "Provision a NAT gateway in the shared VPC. Default false — the baked bastion AMI needs no internet at boot, and AWS APIs are reached via VPC endpoints."
  type        = bool
  default     = false
}

variable "bastion_ami_id" {
  description = "AMI for the bastion. Empty uses the latest Packer-built cloudcart-bastion-* AMI; set an ami-... ID to pin a specific build."
  type        = string
  default     = ""
}

variable "ssh_ingress_cidrs" {
  description = "CIDRs allowed to SSH into the bastion. Defaults to [] (SSM Session Manager only, no inbound). Set to your admin CIDR(s) only if you also want SSH — note the private bastion has no public IP, so SSH would require in-VPC/peered access."
  type        = list(string)
  default     = []
}

variable "cloudtrail_bucket_name" {
  description = "S3 bucket name for the account CloudTrail logs"
  type        = string
  default     = "cloudcart-cloudtrail-logs"
}

variable "config_bucket_name" {
  description = "S3 bucket name for AWS Config snapshots/history"
  type        = string
  default     = "cloudcart-config-logs"
}
