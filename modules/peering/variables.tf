variable "name" {
  description = "Name tag for the peering connection"
  type        = string
}

variable "requester_vpc_id" {
  description = "VPC ID on the requester side (the shared/hub VPC)"
  type        = string
}

variable "requester_cidr" {
  description = "CIDR of the requester (hub) VPC"
  type        = string
}

variable "requester_route_table_ids" {
  description = "Route tables on the requester side that need a route to the accepter CIDR"
  type        = list(string)
}

variable "accepter_vpc_id" {
  description = "VPC ID on the accepter side (a spoke/environment VPC)"
  type        = string
}

variable "accepter_cidr" {
  description = "CIDR of the accepter (spoke) VPC"
  type        = string
}

variable "accepter_route_table_ids" {
  description = "Route tables on the accepter side that need a route back to the requester CIDR"
  type        = list(string)
}

variable "tags" {
  description = "Tags to apply to the peering connection"
  type        = map(string)
  default     = {}
}
