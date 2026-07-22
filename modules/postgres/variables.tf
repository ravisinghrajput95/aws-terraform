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

variable "vpc_name" {
  description = "Name of AWS VPC"
  type        = string
  default     = "cloudcart-vpc"
}

variable "private_subnet" {
  description = "Prefix to be used for Private subnet name"
  type        = string
  default     = "Private"
}

variable "public_subnet" {
  description = "Prefix to be used for Private subnet name"
  type        = string
  default     = "Public"
}

variable "private_subnet_prefix" {
  description = "Prefix to be used for Private subnet name"
  type        = string
  default     = "Private"
}

variable "public_subnet_prefix" {
  description = "Prefix to be used for Public subnet name"
  type        = string
  default     = "Public"
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

variable "private_subnet_names" {
  description = "Private subnet name "
  type        = list(string)
}

variable "db_name" {
  type    = string
  default = "cloudcartdevdb"
}

variable "region" {
  description = "AWS region to deploy our resources"
  type        = string
  default     = "us-west-2"
}