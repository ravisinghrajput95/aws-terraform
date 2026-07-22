variable "bucket_name" {
  description = "Name of the S3 bucket to hold Terraform state"
  type        = string
}

variable "kms_key_arn" {
  description = "KMS key ARN for state encryption. Empty uses SSE-S3 (AES256)."
  type        = string
  default     = ""
}

variable "noncurrent_version_expiration_days" {
  description = "Days to retain noncurrent state versions before expiry"
  type        = number
  default     = 90
}

variable "tags" {
  description = "Tags applied to the bucket"
  type        = map(string)
  default     = {}
}
