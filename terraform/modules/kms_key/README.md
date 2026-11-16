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
| [aws_kms_alias.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_deletion_window_in_days"></a> [deletion\_window\_in\_days](#input\_deletion\_window\_in\_days) | Number between 7 and 30, the duration a kms key is in pending state before deletion. | `number` | `30` | no |
| <a name="input_description"></a> [description](#input\_description) | Description of what the given KMS key protects. | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | Lowercase alphanumeric string which can include hyphens, used to generate the key alias 'alias/{name}'. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of key/value tags to attach to the KMS key. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_alias_arn"></a> [alias\_arn](#output\_alias\_arn) | The ARN of the kms key alias. |
| <a name="output_alias_name"></a> [alias\_name](#output\_alias\_name) | The alias of the kms key created. |
| <a name="output_key_arn"></a> [key\_arn](#output\_key\_arn) | The ARN of the kms key created. |
| <a name="output_key_id"></a> [key\_id](#output\_key\_id) | The scoped unique identifier of the kms key created. |
<!-- END_TF_DOCS -->
