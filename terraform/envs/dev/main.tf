locals {
  project = "mini-storage"
  env     = "dev"

  tags = {
    project    = local.project
    env        = local.env
    managed_by = "terraform"
  }
}

# Use the account's default VPC to keep Phase 1 simple. Building your own VPC with
# private subnets is a good stretch goal: it's what production does.
#
# TODO (when you wire up RDS/Redis): uncomment these data sources.
# data "aws_vpc" "default" {
#   default = true
# }
#
# data "aws_subnets" "default" {
#   filter {
#     name   = "vpc-id"
#     values = [data.aws_vpc.default.id]
#   }
# }

module "kms" {
  source = "../../modules/kms_key"

  # TODO: name = "${local.project}-${local.env}"
}

# The expensive modules are behind feature flags. `count = 0` means "declared but not created".
# Refer to them as module.postgres[0].endpoint.
module "postgres" {
  source = "../../modules/rds_postgres"
  count  = var.enable_rds ? 1 : 0

  # TODO: name, kms_key_arn, vpc_id, subnet_ids, deletion_protection = false, skip_final_snapshot = true
}

module "redis" {
  source = "../../modules/elasticache_redis"
  count  = var.enable_redis ? 1 : 0

  # TODO: name, kms_key_arn, vpc_id, subnet_ids
}
