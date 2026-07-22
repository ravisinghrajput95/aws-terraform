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
    condition     = contains(["dev", "qa", "stage", "production", "shared"], var.environment)
    error_message = "Environment must be one of: dev, qa, stage, production, shared"
  }
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string

}

variable "subnet_newbits" {
  description = "Additional bits to extend the VPC prefix by when carving subnets (8 => /24 subnets from a /16; use a smaller value for a shorter VPC CIDR)"
  type        = number
  default     = 8
}

variable "enable_nat_gateway" {
  description = "Provision a NAT gateway for private-subnet internet egress. Spokes need it; the shared bastion VPC can set this false and rely on VPC endpoints."
  type        = bool
  default     = true
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
