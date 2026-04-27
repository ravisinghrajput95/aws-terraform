output "db_instance_name" {
  value = module.postgres.db_instance_name
}

output "db_instance_address" {
  value = module.postgres.db_instance_address
}

output "db_instance_endpoint" {
  value = module.postgres.db_instance_endpoint
}

output "db_parameter_group_id" {
  value = module.postgres.db_parameter_group_id
}

output "db_subnet_group_id" {
  value = module.postgres.db_subnet_group_id
}

output "read_replica_endpoint" {
  value = length(aws_db_instance.read_replica) > 0 ? aws_db_instance.read_replica[0].endpoint : null
}

output "read_replica_address" {
  value = length(aws_db_instance.read_replica) > 0 ? aws_db_instance.read_replica[0].address : null
}

output "read_replica_instance_class" {
  value = length(aws_db_instance.read_replica) > 0 ? aws_db_instance.read_replica[0].instance_class : null
}

output "read_replica_allocated_storage" {
  value = length(aws_db_instance.read_replica) > 0 ? aws_db_instance.read_replica[0].allocated_storage : null
}

