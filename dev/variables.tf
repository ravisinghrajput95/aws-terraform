variable "aws_region" {
  description = "AWS  region where all services will be provisioned"
  type        = string
  default     = "us-west-2"
}

variable "vpc_name" {
  description = "Name of AWS VPC"
  type        = string
  default     = "accord-vpc"
}

variable "environment" {
  description = "Environment for which VPC is being created (dev, qa, staging, production)"
  type        = string

  validation {
    condition     = contains(["dev", "qa", "stage", "production"], var.environment)
    error_message = "Environment must be one of: dev, qa, stage, production"
  }
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string

}

variable "private_subnet" {
  description = "Prefix to be used for Private subnet name"
  type        = string
  default     = "Private"
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

variable "password" {
  description = "Master user password for the RDS DB instance"
  type        = string
  sensitive   = true # Mark the variable as sensitive to mask its value in logs and outputs
}

variable "region" {
  description = "AWS region to deploy our resources"
  type        = string
  default     = "us-west-2"
}

variable "public_subnet_ids" {
  description = "public subnet where the bastion host will get provisioned"
  type        = list(string)
  default     = []
}

variable "security_group_id" {
  description = "security group for inbound/outbound traffic"
  type        = string
  default     = ""
}

variable "bastion_complete_public_ip" {
  description = "bastion host public ip"
  type        = string
  default     = ""
}

variable "iam_instance_profile" {
  description = "bastion host iam profile arn"
  type        = string
  default     = ""
}

variable "vpc_id" {
  description = "vpc id"
  type        = string
  default     = ""
}

variable "iam_role_arn" {
  description = "iam role"
  type        = string
  default     = ""
}

variable "account_id" {
  description = "The AWS account ID"
  type        = string
}

variable "repository_names" {
  description = "The names of the ECR repositories"
  type        = list(string)
}