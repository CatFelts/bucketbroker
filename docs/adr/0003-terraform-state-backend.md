# 3. Terraform state backend

- Status: Accepted
- Date: 2026-10-29

## Context
Terraform state maps your config to real resources. It can contain sensitive values, and if two
`apply` runs happen at once they can corrupt it. Teams keep state in remote, locked, encrypted storage.

Before Terraform 1.10, the S3 backend needed a DynamoDB table for locking. Since 1.10, `use_lockfile = true`
locks using S3 conditional writes, and the DynamoDB option is deprecated.

## Decision
- `envs/local`: local state file (gitignored). Resources are throwaway.
- `envs/dev`: start with local state. Once comfortable, move to an S3 backend with versioning and
  encryption turned on and `use_lockfile = true`. Migrate with `terraform init -migrate-state`.
- The state bucket itself is created outside this config (by hand, or with a tiny bootstrap config),
  because a config can't store its state in a bucket it creates.

## Consequences
- No DynamoDB table to manage.
- Versioning on the state bucket gives you a way to recover from a bad state write.
- Never edit state by hand. Use `terraform state mv`, or `moved {}` / `import {}` blocks.
