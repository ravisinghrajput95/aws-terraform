# CloudCart — AWS Terraform (Multiple Environments)

Terraform configuration that provisions CloudCart's AWS infrastructure across
`dev`, `qa`, `stage`, and `production` from a shared set of modules (VPC, EKS,
RDS Postgres, ECR, bastion, security groups, IAM). All provisioned resources
are named with the `cloudcart` prefix.

## CI/CD

GitHub Actions workflows:

- **`terraform-ci.yml`** — on Terraform changes: `fmt`, `validate` (all envs,
  offline), and `plan` for the spoke envs (dev/qa/stage/production) via AWS
  OIDC. `shared` is validated but not planned in CI (it depends on the other
  envs' remote state).
- **`checkov.yml`** — static security/compliance analysis, SARIF uploaded to
  GitHub code scanning (`soft_fail`, offline).
- **`infracost.yml`** — cost estimate per env (defined in `infracost.yml`),
  parsed from HCL (no AWS needed), posted as a single PR comment.
- **`terraform-docs.yml`** — regenerates each module's `README.md`
  (inputs/outputs tables) and commits the update back to the PR branch.
- **`packer-bastion.yml`** — validates and builds the bastion AMI (see
  `packer/README.md`).

### Required repo configuration (Settings → Secrets and variables → Actions)

**Variables**

| Name | Used by | Purpose |
|---|---|---|
| `AWS_TF_ROLE_ARN` | terraform-ci | OIDC role for `terraform plan` (read access + state backend) |
| `AWS_PACKER_ROLE_ARN` | packer | OIDC role to build AMIs |
| `AWS_REGION` | both | region (optional, default `us-west-2`) |
| `PACKER_SUBNET_ID` | packer | build subnet with egress (optional) |

**Secrets**

| Name | Used by | Purpose |
|---|---|---|
| `INFRACOST_API_KEY` | infracost | Infracost cost estimates/comments |
| `AWS_ACCOUNT_ID` | terraform-ci | value for the `account_id` variable during plan |

Both workflows authenticate with **GitHub OIDC** — no long-lived AWS keys.
`plan`/`infracost` never run for fork PRs.
