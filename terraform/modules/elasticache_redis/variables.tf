# Suggested inputs:
#
#   name                        string        required. Validate max 40 chars, lowercase.
#   kms_key_arn                 string        required
#   vpc_id                      string        required
#   subnet_ids                  list(string)  required
#   allowed_cidr_blocks         list(string)  default []
#   engine                      string        default "valkey". Validate contains(["valkey","redis"], ...).
#   engine_version              string
#   node_type                   string        default "cache.t4g.micro"
#   num_cache_clusters          number        default 1
#   automatic_failover_enabled  bool          default false
#   snapshot_retention_limit    number        default 0 in dev
#   auth_token                  string        sensitive = true
#   tags                        map(string)   default {}
