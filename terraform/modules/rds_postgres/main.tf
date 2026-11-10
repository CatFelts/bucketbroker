# =============================================================================
# MODULE: rds_postgres  (managed relational storage)
# =============================================================================
#
# !! COSTS MONEY. The LocalStack Hobby plan does NOT emulate RDS. Test on real AWS only:
# !! plan -> apply -> verify -> destroy in a single sitting. Check your budget alert exists first.
#
# GOAL
#   A small, private, encrypted PostgreSQL instance. Postgres must never be reachable from
#   the internet, the password must never appear in Terraform state, and only TLS connections
#   are accepted.
#
# ON-PREM ANALOGY
#   You get a database without managing the box, the RAID set or the backup job. RDS
#   automated backups plus point-in-time recovery do the work of array snapshots plus log
#   shipping. Multi-AZ is roughly synchronous replication to a second array in another rack/site.
#
# RESOURCES TO LOOK UP
#   - aws_db_subnet_group        (which subnets the DB can live in. Use private subnets.)
#   - aws_security_group (+ aws_vpc_security_group_ingress_rule)  allow 5432 only from var.allowed_cidr_blocks or SGs
#   - aws_db_parameter_group     (family "postgres17", parameter rds.force_ssl = 1)
#   - aws_db_instance
#
# BEST PRACTICES TO APPLY
#   [ ] storage_encrypted = true, kms_key_id = var.kms_key_arn
#   [ ] manage_master_user_password = true. RDS stores the password in Secrets Manager,
#       so it never appears in your state file. Also set master_user_secret_kms_key_id.
#   [ ] publicly_accessible = false
#   [ ] instance_class default "db.t4g.micro", allocated_storage 20, storage_type "gp3"
#   [ ] backup_retention_period: an input, at least 1
#   [ ] deletion_protection and skip_final_snapshot are inputs. Dev: false/true. Prod: true/false.
#       Know why these defaults flip between environments.
#   [ ] iam_database_authentication_enabled = true
#   [ ] auto_minor_version_upgrade = true; pin only the major engine_version
#   [ ] multi_az is an input (default false, to save cost)
#
# DONE WHEN
#   [ ] `make check` passes
#   [ ] In envs/dev with enable_rds = true: apply succeeds (~5–10 min), and you can see the
#       secret in Secrets Manager
#   [ ] Destroy succeeds, and you confirm in the console that nothing is left
#   [ ] You can explain: Multi-AZ vs read replica, automated backup vs manual snapshot,
#       and why the subnet group needs 2+ AZs even for a single-AZ instance
# =============================================================================
