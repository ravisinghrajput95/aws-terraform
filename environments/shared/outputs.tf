output "shared_vpc_id" {
  description = "ID of the shared bastion VPC"
  value       = module.vpc.vpc_id
}

output "shared_vpc_cidr" {
  description = "CIDR of the shared bastion VPC"
  value       = var.vpc_cidr
}

output "bastion_private_ip" {
  description = "Private IP of the shared bastion host (no public IP — reach it via SSM)"
  value       = module.bastion.bastion_complete_private_ip
}

output "bastion_id" {
  description = "Instance ID of the shared bastion host"
  value       = module.bastion.bastion_complete_id
}

output "peering_connection_ids" {
  description = "Peering connection IDs, keyed by environment"
  value       = { for env, m in module.peering : env => m.peering_connection_id }
}
