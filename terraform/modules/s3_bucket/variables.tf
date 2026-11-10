# Suggested inputs (type + description + validation where useful):
#
#   name                          string       required. Validate S3 naming rules.
#   kms_key_arn                   string       required. Validate that it starts with "arn:".
#   force_destroy                 bool         default false
#   noncurrent_version_expiration number       default 30 (days)
#   tags                          map(string)  default {}
