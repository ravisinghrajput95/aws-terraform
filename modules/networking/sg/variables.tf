

variable "vpc_id" {
  description = "vpc id for the bastion"
  type        = string
}


variable "ssh_ingress_cidrs" {
  description = "CIDRs allowed to SSH (port 22) to the bastion. Empty list disables SSH ingress entirely (rely on SSM Session Manager)."
  type        = list(string)
  default     = []
}
