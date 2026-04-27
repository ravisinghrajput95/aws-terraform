output "db_instance_address" {
  description = "The address of the RDS instance"
  value       = module.db.db_instance_address
}

output "db_instance_arn" {
  description = "The ARN of the RDS instance"
  value       = module.db.db_instance_arn
}

output "db_instance_availability_zone" {
  description = "The availability zone of the RDS instance"
  value       = module.db.db_instance_availability_zone
}

output "db_instance_endpoint" {
  description = "The connection endpoint"
  value       = module.db.db_instance_endpoint
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
