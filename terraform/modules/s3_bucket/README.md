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
<!-- END_TF_DOCS -->
