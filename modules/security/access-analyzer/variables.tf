variable "name" {
  description = "Analyzer name"
  type        = string
  default     = "cloudcart-analyzer"
}

variable "type" {
  description = "Analyzer type: ACCOUNT or ORGANIZATION (also *_UNUSED_ACCESS variants)"
  type        = string
  default     = "ACCOUNT"
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = {}
}
