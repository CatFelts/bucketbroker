# rds_postgres

Private, encrypted, TLS-only RDS PostgreSQL. The password is managed in Secrets Manager.

> **Costs money.** LocalStack's free plan doesn't emulate RDS. Use `terraform/envs/dev` with
> `enable_rds = true`, and destroy in the same session.

The build instructions and checklist are in the header of [main.tf](main.tf).

## Usage

```hcl
module "postgres" {
  source = "../../modules/rds_postgres"

  name                = "acme-pg-dev"
  kms_key_arn         = module.kms.key_arn
  vpc_id              = data.aws_vpc.default.id
  subnet_ids          = data.aws_subnets.default.ids
  deletion_protection = false # dev only
  skip_final_snapshot = true  # dev only
  tags                = local.tags
}
```

## Reading

- [RDS security best practices](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_BestPractices.Security.html)
- [RDS + Secrets Manager password management](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/rds-secrets-manager.html)

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->
