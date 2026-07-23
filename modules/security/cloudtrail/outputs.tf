output "trail_arn" {
  description = "ARN of the CloudTrail trail"
  value       = aws_cloudtrail.this.arn
}

output "bucket_id" {
  description = "Log bucket name"
  value       = aws_s3_bucket.trail.id
}

output "kms_key_arn" {
  description = "KMS key ARN used for log encryption"
  value       = aws_kms_key.trail.arn
}
