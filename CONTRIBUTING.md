# Contributing

## Workflow

- Environments are **directories, not branches**. `main` is protected.
- Short-lived branch → PR → `main`. Use Conventional Commit style messages.
- Every PR runs: `terraform fmt`, `validate` (all envs), `tflint`, `checkov`,
  `trivy`, and `plan` (spokes). `terraform-docs` auto-updates module READMEs.

## Local development

```bash
make help          # list targets
make fmt           # format
make validate-all  # validate every config offline
make lint          # tflint
make security      # checkov + trivy
pre-commit install # optional: run fmt/validate/docs/tflint on commit
```

## Adding or changing a module

- Layout: `main.tf`, `variables.tf`, `outputs.tf`, `versions.tf`, and
  `locals.tf` / `data.tf` if needed. **No `provider` blocks in modules** — they
  inherit the root provider.
- Every variable has a `description` and a `type`; add `validation` where it
  helps. Prefer inputs over hardcoded values.
- Update `examples/` when you change a module's interface. READMEs are generated
  by terraform-docs — don't hand-edit the `<!-- BEGIN_TF_DOCS -->` block.

## Apply order

`bootstrap` → `dev` / `qa` / `stage` / `production` → `shared`. See
[docs/architecture.md](docs/architecture.md).
