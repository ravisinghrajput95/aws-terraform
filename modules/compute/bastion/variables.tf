
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string

}



variable "subnet_ids" {
  description = "Subnets to place the bastion in (first is used). Use private subnets for an SSM-only bastion."
  type        = list(string)
  default     = []
}

variable "ami_id" {
  description = "AMI ID for the bastion. Empty looks up the latest self-owned cloudcart-bastion-* AMI built by Packer (packer/)."
  type        = string
  default     = ""
}

variable "associate_public_ip" {
  description = "Whether to give the bastion a public IP. Keep false for a private, SSM-only bastion."
  type        = bool
  default     = false
}

variable "create_eip" {
  description = "Whether to allocate and attach an Elastic IP (only relevant for a public bastion)."
  type        = bool
  default     = false
}

variable "key_name" {
  description = "EC2 key pair for SSH. Empty means no key pair (SSM-only access)."
  type        = string
  default     = ""
}

variable "security_group_id" {
  type    = string
  default = ""
}

variable "iam_role_name" {
  type    = string
  default = ""
}