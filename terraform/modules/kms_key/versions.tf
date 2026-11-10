# Reusable modules declare the *minimum* versions they need, with no upper pin.
# Root configs (terraform/envs/*) choose the exact versions, and .terraform.lock.hcl records them.
# If a module pinned tightly, two modules with different pins couldn't be used together.
terraform {
  required_version = ">= 1.10"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.0"
    }
  }
}
