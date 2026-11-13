output "key_arn" {
  value       = aws_kms_key.this.arn
  description = "The ARN of the kms key created."
}

output "key_id" {
  value       = aws_kms_key.this.key_id
  description = "The scoped unique identifier of the kms key created."
}

output "alias_name" {
  value       = aws_kms_alias.this.name
  description = "The alias of the kms key created."
}

output "alias_arn" {
  value       = aws_kms_alias.this.arn
  description = "The ARN of the kms key alias."
}