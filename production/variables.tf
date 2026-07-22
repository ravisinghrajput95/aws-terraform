variable "aws_region" {
  description = "AWS  region where all services will be provisioned"
  type        = string
  default     = "us-west-2"
}

variable "vpc_name" {
  description = "Name of AWS VPC"
  type        = string
  default     = "cloudcart-vpc"
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


variable "region" {
  description = "AWS region to deploy our resources"
  type        = string
  default     = "us-west-2"
}

variable "account_id" {
  description = "The AWS account ID"
  type        = string
}

variable "repository_names" {
  description = "The names of the ECR repositories"
  type        = list(string)
}
