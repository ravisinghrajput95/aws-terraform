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
  default     = "cloudcart-vpc"
}
