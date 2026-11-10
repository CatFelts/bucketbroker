# =============================================================================
# MODULE: kms_key  (build this FIRST — every other module consumes its ARN)
# =============================================================================
#
# GOAL
#   Create a customer-managed KMS key (CMK) plus a friendly alias. Other modules
#   pass this key's ARN to S3 / SQS / RDS / ElastiCache to encrypt data at rest.
#   In Phase 2, each tenant gets its own key, so one tenant's data can never be
#   decrypted with another tenant's key ("crypto-isolation").
#
# ON-PREM ANALOGY
#   This is like the external key manager (KMIP server) your arrays talk to for
#   self-encrypting drive (SED) keys. KMS never hands out the key itself. Services ask KMS to
#   generate and decrypt *data keys* (envelope encryption). See docs/on-prem-to-cloud.md.
#
# RESOURCES TO LOOK UP (registry.terraform.io/providers/hashicorp/aws/latest/docs)
#   - aws_kms_key
#   - aws_kms_alias
#   - (Phase 2) aws_kms_key_policy, data "aws_iam_policy_document", data "aws_caller_identity"
#
# BEST PRACTICES TO APPLY
#   [ ] enable_key_rotation = true  (trivy flags keys without rotation)
#   [ ] deletion_window_in_days is an input. Use 7 in dev, 30 in prod. KMS deletes are *irreversible*
#       after the window, and any data encrypted only with that key is gone for good.
#   [ ] Alias is derived from inputs, e.g. "alias/${var.name}". Never hardcode it.
#   [ ] description says what the key protects.
#   [ ] Tags are passed through from var.tags.
#   [ ] (Phase 2) Write an explicit key policy rather than relying on the default
#       "the whole account can use it" policy.
#
# DONE WHEN
#   [ ] `make validate lint sec` passes
#   [ ] `make plan-local` shows 2 resources to add (key + alias)
#   [ ] After apply: `awslocal kms list-aliases` shows your alias
#   [ ] You can explain: CMK vs AWS-managed key vs AWS-owned key, and what envelope encryption is
#
# STRETCH
#   - Encrypt and decrypt a string by hand: `awslocal kms encrypt --key-id alias/... --plaintext ...`
# =============================================================================
