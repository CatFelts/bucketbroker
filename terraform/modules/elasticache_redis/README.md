# elasticache_redis

Private ElastiCache replication group (Valkey or Redis), encrypted at rest and in transit.

> **Costs money.** LocalStack's free plan doesn't emulate ElastiCache. Use `terraform/envs/dev` with
> `enable_redis = true`, and destroy in the same session.

The build instructions and checklist are in the header of [main.tf](main.tf).

## Reading

- [ElastiCache data security](https://docs.aws.amazon.com/AmazonElastiCache/latest/dg/encryption.html)
- [ElastiCache for Valkey](https://aws.amazon.com/elasticache/valkey/)

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->
