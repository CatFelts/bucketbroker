# =============================================================================
# MODULE: sqs_queue  ("queue" storage in the platform's API)
# =============================================================================
#
# GOAL
#   A KMS-encrypted SQS queue with a dead-letter queue (DLQ). After N failed
#   receives, a message moves to the DLQ, so a poison message can't block or loop forever.
#
# ON-PREM ANALOGY
#   It plays a role similar to an array's write journal or replication queue: durable, ordered
#   (FIFO only) buffering between producers and consumers. A DLQ is like a quarantine area for
#   I/Os that keep failing.
#
# RESOURCES TO LOOK UP
#   - aws_sqs_queue                    (two of them: main + dlq)
#   - aws_sqs_queue_redrive_policy     (main -> dlq, maxReceiveCount)
#   - aws_sqs_queue_redrive_allow_policy (dlq accepts only from main)
#   - (stretch) aws_sqs_queue_policy
#
# BEST PRACTICES TO APPLY
#   [ ] Set kms_master_key_id = var.kms_key_arn on BOTH queues
#   [ ] Make kms_data_key_reuse_period_seconds an input (default 300). Know the trade-off:
#       KMS cost vs how often data keys are rotated.
#   [ ] Make visibility_timeout_seconds an input. It must be longer than the consumer's
#       processing time, or messages get delivered twice.
#   [ ] Give the DLQ longer message_retention_seconds than the main queue (e.g. 14 days),
#       so you have time to investigate failures
#   [ ] Make max_receive_count an input (default 5)
#   [ ] Add an optional `fifo` bool. FIFO queue names must end in ".fifo". Handle that in a local.
#
# DONE WHEN
#   [ ] `make check` passes
#   [ ] After apply: `awslocal sqs send-message` / `receive-message` round-trip works
#   [ ] Receive a message without deleting it more than max_receive_count times, then confirm
#       it appears in the DLQ
#   [ ] You can explain: standard vs FIFO, at-least-once delivery, why consumers must be idempotent
# =============================================================================
