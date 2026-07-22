variable "aws_region" {
  description = "AWS region for the state buckets"
  type        = string
  default     = "us-west-2"
}

variable "state_buckets" {
  description = "State bucket names to create (one per environment)"
  type        = list(string)
  default = [
    "cloudcart-dev-terraform-state",
    "cloudcart-qa-terraform-state",
    "cloudcart-stage-terraform-state",
    "cloudcart-production-terraform-state",
    "cloudcart-shared-terraform-state",
  ]
}
