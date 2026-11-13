locals {
  project = "bucketbroker"
  env     = "local"

  tags = {
    project    = local.project
    env        = local.env
    managed_by = "terraform"
  }
}

# Wire up modules here as you finish each one. Once a module has required variables,
# `make validate` fails until you pass them below. That's expected: it tells you what's missing.

module "kms" {
  source = "../../modules/kms_key"

  name                    = "${local.project}-${local.env}"
  description             = "protects localstack storage" # validate this is true
  deletion_window_in_days = 7                             # short pending window to keep things tidy
}

module "blob" {
  source = "../../modules/s3_bucket"

  # TODO: name          = "${local.project}-${local.env}-blob"
  # TODO: kms_key_arn   = module.kms.key_arn
  # TODO: force_destroy = true
}

module "queue" {
  source = "../../modules/sqs_queue"

  # TODO: name        = "${local.project}-${local.env}-events"
  # TODO: kms_key_arn = module.kms.key_arn
}

# rds_postgres and elasticache_redis are not available on the LocalStack free plan.
# They are wired up in envs/dev instead.
