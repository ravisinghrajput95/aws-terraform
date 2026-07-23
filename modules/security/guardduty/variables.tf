variable "finding_publishing_frequency" {
  description = "How often GuardDuty exports findings (FIFTEEN_MINUTES, ONE_HOUR, SIX_HOURS)"
  type        = string
  default     = "SIX_HOURS"
}

variable "enable_s3_protection" {
  description = "Enable S3 protection"
  type        = bool
  default     = true
}

variable "enable_kubernetes_protection" {
  description = "Enable EKS audit-log protection"
  type        = bool
  default     = true
}

variable "enable_malware_protection" {
  description = "Enable EC2/EBS malware protection"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags for the detector"
  type        = map(string)
  default     = {}
}
