
variable "environment" {
  description = "The environment to provision the resources"
}


variable "repository_names" {
  description = "The names of the ECR repositories"
  type        = list(string)
}

variable "kms_key_arn" {
  description = "Customer-managed KMS key ARN for ECR image encryption (empty = AES256)"
  type        = string
  default     = ""
}