output "bastion_complete_id" {
  description = "The ID of the instance"
  value       = module.bastion.id
}

output "bastion_complete_arn" {
  description = "The ARN of the instance"
  value       = module.bastion.arn
}

output "bastion_complete_public_ip" {
  description = "The public IP address assigned to the instance"
  value       = resource.aws_eip.bastion.public_ip
}

output "bastion_complete_root_block_device" {
  description = "Root block device information"
  value       = module.bastion.root_block_device
}

output "bastion_complete_ebs_block_device" {
  description = "EBS block device information"
  value       = module.bastion.ebs_block_device
}
