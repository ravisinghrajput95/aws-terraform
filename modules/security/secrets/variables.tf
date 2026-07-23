variable "environment" {
  description = "Environment the secret belongs to (dev, qa, stage, production)"
  type        = string

  validation {
    condition     = contains(["dev", "qa", "stage", "production"], var.environment)
    error_message = "Environment must be one of: dev, qa, stage, production"
  }
}

variable "username" {
  description = "Master DB username stored alongside the generated password"
  type        = string
  default     = "cloudcart_user"
}

variable "secret_name" {
  description = "Optional override for the Secrets Manager secret name. Defaults to cloudcart-<env>-db-password"
  type        = string
  default     = ""
}

variable "password_length" {
  description = "Length of the generated master password"
  type        = number
  default     = 24
}

variable "kms_key_arn" {
  description = "Customer-managed KMS key ARN to encrypt the secret (empty = AWS-managed key)"
  type        = string
  default     = ""
}

variable "recovery_window_in_days" {
  description = "Days AWS retains the secret after deletion before permanent removal (0 for immediate delete, useful in non-prod)"
  type        = number
  default     = 7
}
