# Root configs pin providers more tightly than modules do. `~> 6.0` allows any 6.x and blocks 7.0,
# which may have breaking changes. The exact version is recorded in .terraform.lock.hcl, so commit it.
terraform {
  required_version = ">= 1.10"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  # No backend block: state is kept in a local terraform.tfstate file (gitignored).
  # That's fine for throwaway LocalStack resources. See docs/adr/0003-terraform-state-backend.md.
}
