# =============================================================================
# MODULE: s3_bucket  ("blob" storage in the platform's API)
# =============================================================================
#
# GOAL
#   A private, KMS-encrypted, versioned S3 bucket that is safe by default. A developer
#   using this module should not be able to make a public or unencrypted bucket by accident.
#
# ON-PREM ANALOGY
#   Roughly a storage pool or volume on an object store. Versioning works like snapshots
#   on every write. The public access block acts like a "never zone this to the outside" switch.
#
# RESOURCES TO LOOK UP
#   Since AWS provider v4, S3 settings are *separate resources*, not arguments on aws_s3_bucket:
#   - aws_s3_bucket
#   - aws_s3_bucket_public_access_block
#   - aws_s3_bucket_ownership_controls                     (BucketOwnerEnforced disables ACLs)
#   - aws_s3_bucket_server_side_encryption_configuration   (sse_algorithm = "aws:kms")
#   - aws_s3_bucket_versioning
#   - aws_s3_bucket_lifecycle_configuration
#   - aws_s3_bucket_policy + data "aws_iam_policy_document"
#
# BEST PRACTICES TO APPLY
#   [x] Turn on all four public-access-block settings
#   [x] Use SSE-KMS with var.kms_key_arn, and set bucket_key_enabled = true. S3 Bucket Keys
#       cut KMS request costs a lot. Be ready to explain why.
#   [x] Turn on versioning
#   [ ] Add a bucket policy that denies any request where aws:SecureTransport = "false" (TLS only)
#   [x] Add a lifecycle rule that aborts incomplete multipart uploads after N days and expires
#       noncurrent versions after N days. Otherwise versioning costs grow forever.
#   [x] Add a `force_destroy` input with default false. Set it true only in envs/local and envs/dev.
#   [x] Bucket names are global across *all* AWS accounts. Take a name input and validate it
#       (3–63 chars, lowercase letters, digits, hyphens).
#
# DONE WHEN
#   [ ] `make check` passes. Trivy is the judge of "secure by default".
#   [ ] After apply: `lstk aws s3api get-bucket-encryption --bucket <name>` shows aws:kms
#   [ ] `lstk aws s3 cp README.md s3://<name>/` works, and a second upload creates a new version
#   [ ] You can explain: SSE-S3 vs SSE-KMS vs SSE-C, and why ACLs are disabled today
#
# STRETCH
#   - Access logging to a separate log bucket (trivy will suggest this)
#   - Object Lock (WORM). It matters for DocuSign-style compliance and audit data.
# =============================================================================

resource "aws_s3_bucket" "this" {
  bucket              = var.name
  object_lock_enabled = var.object_lock_enabled
  tags                = var.tags
  force_destroy       = var.force_destroy
}
#reference https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket

resource "aws_s3_bucket_public_access_block" "this" {
  bucket                  = aws_s3_bucket.this.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_ownership_controls" "this" {
  bucket = aws_s3_bucket.this.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = var.kms_key_arn
    }
    bucket_key_enabled = true
  }
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "this" {
  bucket = aws_s3_bucket.this.id
  rule {
    id = "version_lifecycle_rule"

    noncurrent_version_expiration {
      noncurrent_days = var.noncurrent_version_expiration
    }

    status = "Enabled"

  }

  rule {
    id = "multipart_lifecycle_rule"

    abort_incomplete_multipart_upload {
      days_after_initiation = var.abort_incomplete_multipart_upload
    }

    status = "Enabled"
  }
}
