# Suggested inputs:
#
#   name                     string        required. Used as the DB identifier.
#   kms_key_arn              string        required
#   vpc_id                   string        required
#   subnet_ids               list(string)  required. Validate length >= 2.
#   allowed_cidr_blocks      list(string)  default []. Who can reach port 5432.
#   engine_version           string        default "17"
#   instance_class           string        default "db.t4g.micro"
#   allocated_storage        number        default 20
#   backup_retention_period  number        default 1
#   multi_az                 bool          default false
#   deletion_protection      bool          default true. Safe by default; dev overrides it.
#   skip_final_snapshot      bool          default false. Safe by default; dev overrides it.
#   tags                     map(string)   default {}
