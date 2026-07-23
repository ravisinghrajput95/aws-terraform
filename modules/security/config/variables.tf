variable "name" {
  description = "Name for the Config recorder / delivery channel"
  type        = string
  default     = "cloudcart-config"
}

variable "bucket_name" {
  description = "S3 bucket name for Config snapshots/history"
  type        = string
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
