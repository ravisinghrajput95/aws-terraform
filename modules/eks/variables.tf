variable "vpc_id" {
  type = string
}

variable "vpc_name" {
  type    = string
  default = "cloudcart-vpc"
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

variable "region" {
  description = "AWS region to deploy our resources"
  type        = string
  default     = "us-west-2"
}

variable "bastion_complete_public_ip" {
  description = "Public ip of the bastion host"
  type        = string
}

variable "security_group_id" {
  description = "security group id for inbound/outbound traffic"
  type        = string
}

variable "iam_role_arn" {
  type    = string
  default = ""
}
