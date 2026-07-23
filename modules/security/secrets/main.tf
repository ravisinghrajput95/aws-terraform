# Generate a strong master password. Excludes characters RDS disallows
# in passwords ('/', '@', '"', and spaces).
resource "random_password" "db" {
  length           = var.password_length
  special          = true
  override_special = "!#$%&*()-_=+[]{}:?"
}

# Store the credentials in AWS Secrets Manager.
resource "aws_secretsmanager_secret" "db" {
  name                    = local.secret_name
  description             = "Master DB credentials for CloudCart ${var.environment}"
  recovery_window_in_days = var.recovery_window_in_days
  tags                    = local.tags
}

resource "aws_secretsmanager_secret_version" "db" {
  secret_id = aws_secretsmanager_secret.db.id
  secret_string = jsonencode({
    username = var.username
    password = random_password.db.result
  })
}
