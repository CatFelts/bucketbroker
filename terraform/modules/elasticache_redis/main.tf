# =============================================================================
# MODULE: elasticache_redis  (managed in-memory cache / key-value store)
# =============================================================================
#
# !! COSTS MONEY. The LocalStack Hobby plan does NOT emulate ElastiCache. Use the same
# !! routine as RDS: plan -> apply -> verify -> destroy in a single sitting.
#
# GOAL
#   A small, private cache cluster encrypted at rest (with your KMS key) and in transit (TLS),
#   with authentication turned on.
#
# ON-PREM ANALOGY
#   Like the array's DRAM / NVRAM cache layer, offered as a service that apps talk to directly.
#   It's fast but not the system of record. Plan for it to lose data.
#
# ENGINE CHOICE: redis vs valkey
#   AWS now steers new clusters toward Valkey, an open-source Redis fork that works with
#   Redis clients and costs less on ElastiCache. Make `engine` an input ("valkey" or "redis") and
#   be ready to explain the licensing history. It's a good interview topic.
#
# RESOURCES TO LOOK UP
#   - aws_elasticache_subnet_group
#   - aws_security_group (+ ingress rule for 6379 from allowed sources only)
#   - aws_elasticache_replication_group  (use this, not aws_elasticache_cluster: it supports
#                                          encryption-in-transit and failover)
#   - (stretch) aws_elasticache_user + aws_elasticache_user_group for RBAC instead of a single auth token
#
# BEST PRACTICES TO APPLY
#   [ ] at_rest_encryption_enabled = true, kms_key_id = var.kms_key_arn
#   [ ] transit_encryption_enabled = true
#   [ ] Authentication: an auth_token from a sensitive variable, or RBAC user groups.
#       Mark the variable `sensitive = true`. Note: it still ends up in state. Know why
#       that matters and how you'd avoid it (RBAC, or a password managed in Secrets Manager).
#   [ ] node_type default "cache.t4g.micro", num_cache_clusters = 1 in dev
#   [ ] automatic_failover_enabled / multi_az_enabled are inputs (they need 2+ nodes)
#   [ ] snapshot_retention_limit is an input
#
# DONE WHEN
#   [ ] `make check` passes
#   [ ] In envs/dev with enable_redis = true: apply succeeds, destroy succeeds
#   [ ] You can explain: cluster mode disabled vs enabled (sharding), and cache-aside vs write-through
# =============================================================================
