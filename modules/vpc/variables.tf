
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

variable "single_nat_gateway" {
  description = "Use one NAT gateway for the whole VPC (cheaper) instead of one per AZ (highly available). Set false for production/stage."
  type        = bool
  default     = true
}

variable "enable_flow_logs" {
  description = "Enable VPC Flow Logs to a CloudWatch log group"
  type        = bool
  default     = true
}

variable "flow_log_retention_days" {
  description = "Retention (days) for the VPC Flow Logs CloudWatch group"
  type        = number
  default     = 90
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
