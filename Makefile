# Run `make help` to see targets.
# Each quality target runs the same checks as CI, so "works on my machine" means "passes CI".

SHELL := /bin/bash
.DEFAULT_GOAL := help

TF_DIRS    := $(shell find terraform -name '*.tf' -not -path '*/.terraform/*' -exec dirname {} \; | sort -u)
MODULES    := $(wildcard terraform/modules/*)
LOCAL_ENV  := terraform/envs/local

.PHONY: help
help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## ' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-16s\033[0m %s\n", $$1, $$2}'

## ---- Quality checks (same as CI) ----

.PHONY: fmt
fmt: ## Format all Terraform files in place
	terraform fmt -recursive terraform

.PHONY: fmt-check
fmt-check: ## Fail if any Terraform file is not formatted
	terraform fmt -recursive -check -diff terraform

.PHONY: validate
validate: ## terraform init (no backend) + validate in every Terraform directory
	@set -e; for d in $(TF_DIRS); do \
		echo "==> validate $$d"; \
		terraform -chdir=$$d init -backend=false -input=false -no-color >/dev/null; \
		terraform -chdir=$$d validate -no-color; \
	done

.PHONY: lint
lint: ## Run tflint against every Terraform directory
	tflint --init --config "$(CURDIR)/.tflint.hcl"
	tflint --recursive --config "$(CURDIR)/.tflint.hcl"

.PHONY: sec
sec: ## Scan Terraform for security misconfigurations with trivy
	trivy config --exit-code 1 --severity HIGH,CRITICAL terraform

.PHONY: docs
docs: ## Regenerate module README input/output tables with terraform-docs
	@for m in $(MODULES); do terraform-docs markdown table --output-file README.md --output-mode inject $$m; done

.PHONY: check
check: fmt-check validate lint sec ## Run every check CI runs

## ---- LocalStack workflow ----

.PHONY: local-up
local-up: ## Start LocalStack (needs LOCALSTACK_AUTH_TOKEN in .env)
	docker compose up -d --wait
	@echo "LocalStack ready on http://localhost:4566"

.PHONY: local-down
local-down: ## Stop LocalStack (all emulated resources are lost)
	docker compose down

.PHONY: plan-local
plan-local: ## terraform plan against LocalStack
	terraform -chdir=$(LOCAL_ENV) init -input=false
	terraform -chdir=$(LOCAL_ENV) plan -out=tfplan

.PHONY: apply-local
apply-local: ## Apply the saved local plan (run plan-local first)
	terraform -chdir=$(LOCAL_ENV) apply tfplan

.PHONY: destroy-local
destroy-local: ## Destroy everything in the local env
	terraform -chdir=$(LOCAL_ENV) destroy

## ---- Housekeeping ----

.PHONY: clean
clean: ## Remove .terraform dirs and saved plans (not state)
	find terraform -type d -name .terraform -prune -exec rm -rf {} +
	find terraform -name tfplan -delete
