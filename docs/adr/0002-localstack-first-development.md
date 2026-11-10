# 2. LocalStack-first development

- Status: Accepted
- Date: 2026-10-29

## Context
The goal is to learn by running `apply` and `destroy` many times. Real AWS charges for RDS and ElastiCache
while they run, and a forgotten resource can cost real money. A fast, free feedback loop matters.

Since release 2026.03.0, LocalStack ships as one image that needs an auth token. The free **Hobby**
plan (non-commercial use) covers the services from the old community edition, including S3, SQS,
KMS, IAM and STS. RDS, ElastiCache and IAM policy *enforcement* need a paid plan.

## Decision
- `terraform/envs/local` targets LocalStack for S3, SQS and KMS. This is the default dev loop.
- `terraform/envs/dev` targets real AWS. RDS and ElastiCache sit behind `enable_rds` / `enable_redis`
  flags (default `false`), and are applied only in sessions that end with `destroy`.
- The same modules are used in both environments. Only provider configuration differs.

## Consequences
- Iteration is near-free for most of Phases 1–2.
- **IAM isolation (Phase 2) can't be proven on LocalStack Hobby**, because it doesn't enforce policies.
  Tenant-isolation tests have to run on real AWS (IAM is free) or use the IAM policy simulator.
- LocalStack behavior differs from AWS in places. Anything that passes locally gets a final check on AWS.
- Alternatives considered: moto (Python-only, mock-level), Floci (newer, MIT-licensed, no token). Revisit
  if LocalStack's terms change again.
