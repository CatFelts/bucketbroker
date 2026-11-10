# sqs_queue

KMS-encrypted SQS queue with a dead-letter queue. This is the "queue" storage type.

The build instructions and checklist are in the header of [main.tf](main.tf).

## Usage

```hcl
module "queue" {
  source = "../../modules/sqs_queue"

  name        = "acme-events"
  kms_key_arn = module.kms.key_arn
  tags        = local.tags
}
```

## Reading

- [SQS dead-letter queues](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-dead-letter-queues.html)
- [SQS encryption at rest](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-server-side-encryption.html)

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->
