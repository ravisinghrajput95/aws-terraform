output "password" {
  description = "Generated master DB password"
  value       = random_password.db.result
  sensitive   = true
}

output "username" {
  description = "Master DB username stored in the secret"
  value       = var.username
}

output "secret_arn" {
  description = "ARN of the Secrets Manager secret holding the DB credentials"
  value       = aws_secretsmanager_secret.db.arn
}

output "secret_name" {
  description = "Name of the Secrets Manager secret"
  value       = aws_secretsmanager_secret.db.name
}

output "secret_version_id" {
  description = "Version ID of the stored secret value"
  value       = aws_secretsmanager_secret_version.db.version_id
}
