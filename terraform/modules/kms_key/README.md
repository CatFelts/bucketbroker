# kms_key

Customer-managed KMS key and alias. Every other module uses it for encryption at rest.

The build instructions and checklist are in the header of [main.tf](main.tf).

## Usage

```hcl
module "kms" {
  source = "../../modules/kms_key"

  name = "acme-storage"
  tags = local.tags
}
```

## Reading

- [AWS KMS concepts: keys, aliases, envelope encryption](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html)
- [Key rotation](https://docs.aws.amazon.com/kms/latest/developerguide/rotate-keys.html)

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->
