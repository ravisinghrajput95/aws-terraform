variable "name" {
  description = "CloudTrail trail name"
  type        = string
  default     = "cloudcart-trail"
}

variable "bucket_name" {
  description = "S3 bucket name for CloudTrail logs"
  type        = string
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = {}
}
