variable "name" {
  description = "Name for the Config recorder / delivery channel"
  type        = string
  default     = "cloudcart-config"
}

variable "bucket_name" {
  description = "S3 bucket name for Config snapshots/history"
  type        = string
}

variable "kms_key_arn" {
  description = "Customer-managed KMS key ARN for the Config delivery bucket (empty = SSE-S3/AES256)"
  type        = string
  default     = ""
}

variable "include_global_resource_types" {
  description = "Record global resources (IAM, etc.). Enable in exactly one region."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = {}
}
