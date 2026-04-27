variable "region" {
  description = "AWS region to deploy our resources"
  type        = string
  default     = "us-west-2"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string

}

variable "vpc_id" {
  description = "vpc id for the bastion"
  type        = string
}

variable "vpc_name" {
  description = "name of the vpc"
  type        = string
  default     = "cyber-compliance-tsa"
}

variable "public_subnet_ids" {
  description = "public subnet where the bastion host will get provisioned"
  type        = list(string)
  default     = []
}

variable "security_group_id" {
  type    = string
  default = ""
}

variable "iam_role_name" {
  type    = string
  default = ""
}