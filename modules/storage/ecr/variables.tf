
variable "environment" {
  description = "The environment to provision the resources"
}


variable "repository_names" {
  description = "The names of the ECR repositories"
  type        = list(string)
}