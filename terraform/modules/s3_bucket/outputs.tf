# Suggested outputs:
#
#   bucket_id    the bucket name
#   bucket_arn   the bucket ARN. Phase 2 IAM policies need it.
output "bucket_id" {
  value       = aws_s3_bucket.this.id
  description = "The name of the bucket created."
}

output "bucket_arn" {
  value       = aws_s3_bucket.this.arn
  description = "The ARN of the bucket created."
}
