variable "username" {
  type    = string
  default = "cloudcart_user"
}

variable "environment" {
  description = "Environment for which VPC is being created (dev, qa, staging, production)"
  type        = string

  validation {
    condition     = contains(["dev", "qa", "stage", "production"], var.environment)
    error_message = "Environment must be one of: dev, qa, stage, production"
  }
}

variable "password" {
  description = "Master user password for the RDS DB instance"
  type        = string
  sensitive   = true
}

variable "private_subnet_ids" {
  description = "Private subnet ids to provision RDS Postgres instance"
  type        = list(string)
}

variable "vpc_id" {
  type = string
}






variable "cidr_blocks" {
  description = "CIDR blocks of VPC subnet"
  type        = string
}

variable "bastion_cidr" {
  description = "CIDR of the shared bastion VPC allowed to reach the DB over peering (empty to disable)"
  type        = string
  default     = ""
}


variable "db_name" {
  type    = string
  default = "cloudcartdevdb"
}

