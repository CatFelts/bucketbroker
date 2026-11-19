# s3_bucket

Private, KMS-encrypted, versioned S3 bucket. This is the "blob" storage type.

The build instructions and checklist are in the header of [main.tf](main.tf).

## Usage

```hcl
module "blob" {
  source = "../../modules/s3_bucket"

  name          = "acme-blob-local"
  kms_key_arn   = module.kms.key_arn
  force_destroy = true # local/dev only
  tags          = local.tags
}
```

## Reading

- [S3 security best practices](https://docs.aws.amazon.com/AmazonS3/latest/userguide/security-best-practices.html)
- [S3 Bucket Keys](https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucket-key.html)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.10 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.73.0 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [aws_s3_bucket.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_lifecycle_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration) | resource |
| [aws_s3_bucket_ownership_controls.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls) | resource |
| [aws_s3_bucket_public_access_block.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_abort_incomplete_multipart_upload"></a> [abort\_incomplete\_multipart\_upload](#input\_abort\_incomplete\_multipart\_upload) | Number of days after S3 will abort an incomplete multipart upload. | `number` | `30` | no |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | Inidcates all objects, including locked objects, should be deleted from the bucket when the bucket is destroyed. | `bool` | `false` | no |
| <a name="input_kms_key_arn"></a> [kms\_key\_arn](#input\_kms\_key\_arn) | ARN of the KMS key used to encrypt the bucket data | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of the AWS S3 Bucket | `string` | n/a | yes |
| <a name="input_noncurrent_version_expiration"></a> [noncurrent\_version\_expiration](#input\_noncurrent\_version\_expiration) | Specifies the number of days an object is noncurrent before S3 can expire the object. | `number` | `30` | no |
| <a name="input_object_lock_enabled"></a> [object\_lock\_enabled](#input\_object\_lock\_enabled) | When enabled, the bucket is created with the ability to use object locking. When false, the bucket is created without the abilty to use object locking. | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of key/value tags to attach to the KMS key. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_bucket_arn"></a> [bucket\_arn](#output\_bucket\_arn) | The ARN of the bucket created. |
| <a name="output_bucket_id"></a> [bucket\_id](#output\_bucket\_id) | The name of the bucket created. |
<!-- END_TF_DOCS -->
