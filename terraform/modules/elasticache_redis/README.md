# elasticache_redis

Private ElastiCache replication group (Valkey or Redis), encrypted at rest and in transit.

> **Costs money.** LocalStack's free plan doesn't emulate ElastiCache. Use `terraform/envs/dev` with
> `enable_redis = true`, and destroy in the same session.

The build instructions and checklist are in the header of [main.tf](main.tf).

## Reading

- [ElastiCache data security](https://docs.aws.amazon.com/AmazonElastiCache/latest/dg/encryption.html)
- [ElastiCache for Valkey](https://aws.amazon.com/elasticache/valkey/)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.10 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.0 |

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END_TF_DOCS -->
