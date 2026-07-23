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

variable "enable_enhanced_monitoring" {
  description = "Enable RDS Enhanced Monitoring (creates a monitoring IAM role)"
  type        = bool
  default     = true
}

variable "monitoring_interval" {
  description = "Enhanced Monitoring interval in seconds (1,5,10,15,30,60)"
  type        = number
  default     = 60
}

variable "enable_performance_insights" {
  description = "Enable RDS Performance Insights"
  type        = bool
  default     = true
}

variable "performance_insights_retention_period" {
  description = "Performance Insights retention in days (7 = free tier, or 731)"
  type        = number
  default     = 7
}


variable "db_name" {
  type    = string
  default = "cloudcartdevdb"
}

