# On-prem storage → cloud: a translation table

Use this in interviews. It shows that your hardware storage background carries over to cloud work.
Add rows as you learn. The "where it differs" column is the most valuable one.

| On-prem concept | Cloud equivalent (AWS) | Where it differs |
|---|---|---|
| Storage pool / aggregate | S3 bucket, or an AWS account as the boundary | No capacity to pre-allocate. S3 is effectively unlimited, and you pay per GB-month used. |
| LUN / volume / share | S3 bucket or prefix; EBS volume (block); EFS (file) | Object storage has no in-place partial writes. You replace whole objects. |
| LUN masking / zoning / initiator groups | IAM policies + bucket policies + KMS key policies | Access is checked **per API request** against identity, not per host or WWN. Three policy layers must all allow the request. |
| SED + external key manager (KMIP) | KMS customer-managed keys, envelope encryption | Keys never leave KMS. Services ask KMS for data keys. Deleting a key = crypto-shredding the data. |
| Thin provisioning + quotas | No native S3 size quota → the control plane enforces quotas | You build quota enforcement yourself (Phase 2). That's part of what a SaaS storage team does. |
| Snapshots | S3 versioning; RDS automated backups + snapshots | S3 versioning keeps every version, so lifecycle rules are needed to control cost. |
| Synchronous replication / metro cluster | RDS Multi-AZ | Managed for you. Failover takes ~1–2 minutes, with DNS-based cutover. |
| Async replication / DR site | S3 Cross-Region Replication; RDS cross-region read replica | Billed per GB transferred. Replication lag is something you observe, not configure. |
| Write cache / NVRAM | ElastiCache (as an app-level cache) | Not transparent: the app chooses what to cache. Volatile unless snapshots are on. |
| Replication journal / I/O queue | SQS | At-least-once delivery, so consumers must be idempotent. |
| QoS / IOPS limits | gp3 IOPS/throughput settings, S3 request rate per prefix, SQS throughput | S3 scales per prefix (~3,500 writes and ~5,500 reads per second), so key design affects performance. |
| Array management GUI / API | AWS control-plane APIs; Terraform; *this project's control plane* | Everything is an API, so everything can be code. |
| Firmware upgrades | `auto_minor_version_upgrade`, maintenance windows | Upgrades are scheduled by the provider. You choose the window, not whether it happens. |
| Capacity planning | Cost planning + service quotas (e.g. buckets per account) | Limits are per account and per region, and many can be raised on request. |
