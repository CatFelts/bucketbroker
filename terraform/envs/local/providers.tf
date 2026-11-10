# Point the real AWS provider at LocalStack. The same modules then run unchanged against
# real AWS in envs/dev. Only this file differs.
provider "aws" {
  region = "us-east-1"

  # LocalStack accepts any credentials. These are dummy values, not secrets.
  access_key = "test"
  secret_key = "test"

  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  # LocalStack serves buckets at localhost:4566/<bucket> rather than <bucket>.s3.amazonaws.com.
  s3_use_path_style = true

  endpoints {
    s3  = "http://localhost:4566"
    sqs = "http://localhost:4566"
    kms = "http://localhost:4566"
    iam = "http://localhost:4566"
    sts = "http://localhost:4566"
  }

  # default_tags are added to every resource this provider creates. Modules can't forget them.
  default_tags {
    tags = local.tags
  }
}
