variable "alias" {
  description = "Alias for the key (without the 'alias/' prefix)"
  type        = string
}

variable "description" {
  description = "Key description"
  type        = string
  default     = "Customer-managed key"
}

variable "deletion_window_in_days" {
  description = "Waiting period before the key is deleted"
  type        = number
  default     = 30
}

variable "enable_key_rotation" {
  description = "Enable automatic annual key rotation"
  type        = bool
  default     = true
}

variable "service_principals" {
  description = "AWS service principals allowed to use the key (e.g. logs.us-west-2.amazonaws.com)"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags for the key"
  type        = map(string)
  default     = {}
}
