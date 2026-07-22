output "bastion_complete_id" {
  description = "The ID of the instance"
  value       = module.bastion.id
}

output "bastion_complete_arn" {
  description = "The ARN of the instance"
  value       = module.bastion.arn
}

output "bastion_complete_private_ip" {
  description = "The private IP address of the instance"
  value       = module.bastion.private_ip
}

output "bastion_complete_public_ip" {
  description = "The public IP address of the instance (null for a private SSM-only bastion)"
  value       = length(aws_eip.bastion) > 0 ? aws_eip.bastion[0].public_ip : null
}

output "bastion_complete_root_block_device" {
  description = "Root block device information"
  value       = module.bastion.root_block_device
}

output "bastion_complete_ebs_block_device" {
  description = "EBS block device information"
  value       = module.bastion.ebs_block_device
}
