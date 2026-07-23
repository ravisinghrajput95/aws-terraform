output "recorder_name" {
  description = "Config recorder name"
  value       = aws_config_configuration_recorder.this.name
}

output "bucket_id" {
  description = "Config delivery bucket name"
  value       = aws_s3_bucket.config.id
}

output "role_arn" {
  description = "Config service role ARN"
  value       = aws_iam_role.config.arn
}
