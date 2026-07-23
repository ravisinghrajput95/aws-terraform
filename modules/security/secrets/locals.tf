locals {
  secret_name = coalesce(var.secret_name, "cloudcart-${var.environment}-db-password")

  tags = {
    Environment = var.environment
    Application = "cloudcart"
    ManagedBy   = "terraform"
  }
}
