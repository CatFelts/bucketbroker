# tflint catches things `terraform validate` doesn't: invalid instance types,
# deprecated syntax, unused declarations, naming conventions, missing types/descriptions.
config {
  call_module_type = "local"
}

plugin "terraform" {
  enabled = true
  preset  = "recommended"
}

plugin "aws" {
  enabled = true
  version = "0.50.0"
  source  = "github.com/terraform-linters/tflint-ruleset-aws"
}

# Enforce consistent snake_case names for resources, variables and outputs.
rule "terraform_naming_convention" {
  enabled = true
}

# Every variable and output must have a description. These become your module docs.
rule "terraform_documented_variables" {
  enabled = true
}

rule "terraform_documented_outputs" {
  enabled = true
}

rule "terraform_typed_variables" {
  enabled = true
}

rule "terraform_standard_module_structure" {
  enabled = true
}
