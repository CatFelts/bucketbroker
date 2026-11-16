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
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.10 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.0 |

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END_TF_DOCS -->
