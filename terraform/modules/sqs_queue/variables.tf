# Suggested inputs:
#
#   name                               string       required
#   kms_key_arn                        string       required
#   fifo                               bool         default false
#   visibility_timeout_seconds         number       default 30. Validate 0–43200.
#   message_retention_seconds          number       default 345600 (4 days). Validate 60–1209600.
#   max_receive_count                  number       default 5
#   kms_data_key_reuse_period_seconds  number       default 300. Validate 60–86400.
#   tags                               map(string)  default {}
