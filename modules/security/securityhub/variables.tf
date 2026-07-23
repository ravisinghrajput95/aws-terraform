variable "enable_default_standards" {
  description = "Subscribe to the AWS default standards (Foundational Security Best Practices, CIS)"
  type        = bool
  default     = true
}

variable "control_finding_generator" {
  description = "How controls generate findings: SECURITY_CONTROL or STANDARD_CONTROL"
  type        = string
  default     = "SECURITY_CONTROL"
}

variable "auto_enable_controls" {
  description = "Automatically enable new controls as standards are updated"
  type        = bool
  default     = true
}
