variable "environment" {
  description = "Environment for which VPC is being created (dev, qa, staging, production)"
  type        = string

  validation {
    condition     = contains(["dev", "qa", "stage", "production"], var.environment)
    error_message = "Environment must be one of: dev, qa, stage, production"
  }
}

variable "db_names" {
  description = "db names"
  type        = string
  default     = "cyber-compliance-tsa"
}

variable "instance_class" {
  description = "Instance class for RDS"
  type        = string
  default     = "db.t4g.micro"
}

variable "vpc_id" {
  type = string
}

variable "vpc_name" {
  description = "Name of AWS VPC"
  type        = string
  default     = "accord-vpc"
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

variable "private_subnet_ids" {
  type = list(string)
}

variable "cidr_blocks" {
  type = string
}

variable "private_subnet_names" {
  type = list(string)
}

variable "password" {
  description = "Master user password for the RDS DB instance"
  type        = string
  sensitive   = true # Mark the variable as sensitive to mask its value in logs and outputs
}

variable "db_name" {
  type    = string
  default = "accorddb"
}

variable "username" {
  type    = string
  default = "accord_user"
}

variable "region" {
  description = "AWS region to deploy our resources"
  type        = string
  default     = "us-west-2"
}