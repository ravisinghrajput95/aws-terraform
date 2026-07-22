output "shared_vpc_id" {
  description = "ID of the shared bastion VPC"
  value       = module.vpc.vpc_id
}

output "shared_vpc_cidr" {
  description = "CIDR of the shared bastion VPC"
  value       = var.vpc_cidr
}

output "bastion_public_ip" {
  description = "Public IP of the shared bastion host"
  value       = module.bastion.bastion_complete_public_ip
}

output "bastion_id" {
  description = "Instance ID of the shared bastion host"
  value       = module.bastion.bastion_complete_id
}

output "peering_connection_ids" {
  description = "Peering connection IDs, keyed by environment"
  value       = { for env, m in module.peering : env => m.peering_connection_id }
}
