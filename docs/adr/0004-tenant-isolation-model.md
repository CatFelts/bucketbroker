# 4. Tenant isolation model

- Status: **Proposed**. Decide during Phase 2.
- Date: 2026-10-29

## Context
Each tenant's data must be isolated from every other tenant's. There are three common models, from
most to least isolated:

| Model | Isolation | Blast radius | Cost / limits | Ops overhead |
|---|---|---|---|---|
| **Account per tenant** (silo) | Strongest: a hard AWS boundary | One tenant | Account sprawl; needs AWS Organizations | High |
| **Bucket per tenant + KMS key per tenant** (bridge) | Strong: IAM + key policy | One tenant | Per-account bucket quota; KMS ~$1/key/month | Medium |
| **Shared bucket, prefix per tenant** (pool) | Policy-only: one bad policy leaks everything | All tenants | Cheapest; no bucket limit | Low |

Things to research before deciding:
- S3 general purpose bucket quotas per account (check current limits)
- Using IAM policy conditions (`s3:prefix`, `aws:PrincipalTag/tenant`) for attribute-based access control (ABAC)
- How KMS key-per-tenant gives "crypto-shredding": delete the key and the tenant's data is
  unrecoverable. That's useful for data-deletion requests.

## Decision
_TBD in Phase 2. Write down what you chose and why. "Bridge model, because…" is a strong interview answer._

## Consequences
_TBD_
