# Credentials come from your environment (AWS_PROFILE / `aws sso login`), never from this file.
provider "aws" {
  region = var.aws_region

  default_tags {
    tags = local.tags
  }
}
