# 5. Use Community Module vs Write my Own Module

- Status: Accepted
- Date: 2026-11-17

## Context
To complete my mini platform project, I can either use the community aws_s3_bucket module on the Terraform registry, or write my own.
The community registry looks to be built from the same resources I'd write myself, including but not limited to aws_s3_bucket, aws_s3_bucket_public_access_block, and aws_s3_bucket_versioning.

## Decision
- I will write my own module. This project is primarily to learn Terraform and AWS cloud storage techniques, not to release an actual product.
- One goal of the project is to keep users from creating public or unencrypted buckets by accident. Writing my own module will include guardrails so the end user will be ensured their buckets are secure and safe.

## Consequences
- Writing my own module will take longer than using the community module.
- I may write buggy code which needs revisions.
- I will gain a deeper understanding of how to write modules and how to use aws s3.
