output "state_bucket_arns" {
  description = "ARNs of the created state buckets, keyed by bucket name"
  value       = { for name, m in module.state_bucket : name => m.bucket_arn }
}
