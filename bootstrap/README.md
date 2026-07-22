# bootstrap

Creates the S3 buckets that hold every environment's Terraform state.

This config uses a **local backend** on purpose — it's the one thing that must
exist before any remote backend can be initialized (chicken-and-egg). Locking
is **S3-native** (`use_lockfile = true` in each env's backend), so there are no
DynamoDB tables.

## Usage

Run once, before anything else, with credentials that can create S3 buckets:

```bash
cd bootstrap
terraform init
terraform apply
```

This creates (versioned, encrypted, public-access-blocked, TLS-only):

- `cloudcart-dev-terraform-state`
- `cloudcart-qa-terraform-state`
- `cloudcart-stage-terraform-state`
- `cloudcart-production-terraform-state`
- `cloudcart-shared-terraform-state`

After this, `terraform init` in each environment succeeds against its S3
backend. The bootstrap's own state stays local (commit it, or keep it safe);
it changes rarely.
