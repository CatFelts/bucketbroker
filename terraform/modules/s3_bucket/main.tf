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
#   [ ] Turn on all four public-access-block settings
#   [ ] Use SSE-KMS with var.kms_key_arn, and set bucket_key_enabled = true. S3 Bucket Keys
#       cut KMS request costs a lot. Be ready to explain why.
#   [ ] Turn on versioning
#   [ ] Add a bucket policy that denies any request where aws:SecureTransport = "false" (TLS only)
#   [ ] Add a lifecycle rule that aborts incomplete multipart uploads after N days and expires
#       noncurrent versions after N days. Otherwise versioning costs grow forever.
#   [ ] Add a `force_destroy` input with default false. Set it true only in envs/local and envs/dev.
#   [ ] Bucket names are global across *all* AWS accounts. Take a name input and validate it
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
