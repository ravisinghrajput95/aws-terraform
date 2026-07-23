variable "environment" {
  description = "Environment name (used in resource names)"
  type        = string
}

variable "db_instance_id" {
  description = "RDS instance identifier to alarm on"
  type        = string
}

variable "alarm_email" {
  description = "Email to subscribe to the alerts topic (empty = no subscription)"
  type        = string
  default     = ""
}

variable "rds_cpu_threshold" {
  description = "RDS CPU% alarm threshold"
  type        = number
  default     = 80
}

variable "rds_free_storage_bytes" {
  description = "RDS free storage alarm threshold (bytes)"
  type        = number
  default     = 5368709120 # 5 GiB
}

variable "rds_connections_threshold" {
  description = "RDS connection-count alarm threshold"
  type        = number
  default     = 100
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = {}
}
