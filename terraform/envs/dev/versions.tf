terraform {
  required_version = ">= 1.10"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  # Remote state for real AWS. Start with local state for your first few applies. When you're
  # comfortable, create a state bucket by hand (or with a small bootstrap config), then uncomment this
  # and run `terraform init -migrate-state`.
  #
  # use_lockfile = true turns on S3-native state locking (Terraform 1.10+). No DynamoDB table is needed
  # any more. See docs/adr/0003-terraform-state-backend.md.
  #
  # backend "s3" {
  #   bucket       = "<your-unique-state-bucket>"
  #   key          = "bucketbroker/dev/terraform.tfstate"
  #   region       = "<your selected Region>"
  #   encrypt      = true
  #   use_lockfile = true
  # }
}
