
variable "environment" {
  description = "The environment to provision the resources"
}

variable "account_id" {
  description = "The AWS account ID"
  type        = string
}

variable "repository_names" {
  description = "The names of the ECR repositories"
  type        = list(string)
}