variable "vpc_id" {
  type = string
}


variable "private_subnet_ids" {
  type = list(string)
}

variable "environment" {
  type = string

  validation {
    condition     = contains(["dev", "qa", "stage", "production"], var.environment)
    error_message = "Environment must be one of: dev, qa, stage, production"
  }
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string

}


variable "bastion_cidr" {
  description = "CIDR of the shared bastion VPC allowed to reach the cluster API over peering"
  type        = string
}

variable "iam_role_arn" {
  type    = string
  default = ""
}
