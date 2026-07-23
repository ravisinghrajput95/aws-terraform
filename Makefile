ENVS := dev qa stage production shared
DIR  ?= dev
TF   := terraform

.PHONY: help fmt fmt-check validate validate-all plan apply docs lint security bootstrap clean

help: ## Show available targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN{FS=":.*?## "}{printf "  \033[36m%-14s\033[0m %s\n",$$1,$$2}'

fmt: ## Format all Terraform
	$(TF) fmt -recursive

fmt-check: ## Check formatting (CI-style)
	$(TF) fmt -recursive -check -diff

validate: ## Validate one config (DIR=dev)
	cd $(DIR) && $(TF) init -backend=false -input=false >/dev/null && $(TF) validate

validate-all: ## Validate bootstrap + every environment
	@for e in bootstrap $(ENVS); do echo "== $$e =="; $(MAKE) -s validate DIR=$$e; done

plan: ## Plan one config (DIR=dev)
	cd $(DIR) && $(TF) init -input=false && $(TF) plan

apply: ## Apply one config (DIR=dev)
	cd $(DIR) && $(TF) apply

docs: ## Regenerate module READMEs (terraform-docs)
	@for m in modules/*/; do \
		terraform-docs markdown table --output-file README.md --output-mode inject "$$m"; \
	done

lint: ## Run tflint recursively
	tflint --init && tflint --recursive

security: ## Run checkov + trivy config scans
	checkov -d . --quiet --compact || true
	trivy config .

bootstrap: ## Create the state buckets (run once, first)
	cd bootstrap && $(TF) init && $(TF) apply

clean: ## Remove local .terraform dirs and lock files
	find . -type d -name .terraform -prune -exec rm -rf {} + 2>/dev/null || true
	find . -name .terraform.lock.hcl -delete 2>/dev/null || true
