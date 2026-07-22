# CloudCart bastion AMI (Packer)

Bakes the bastion tooling (awscli v2, kubectl, helm, eksctl, k9s,
aws-iam-authenticator, session-manager-plugin, `psql`, jq, git) onto the
**official Amazon Linux 2** base image, so the running bastion needs no
internet egress to bootstrap.

## Build

```bash
cd packer
packer init .
packer build .                          # AMI name: cloudcart-bastion-<timestamp>
# or pin a version label:
packer build -var 'ami_version=v1' .    # AMI name: cloudcart-bastion-v1
```

The resulting AMI is tagged `Application=cloudcart`, `Role=bastion` and named
`cloudcart-bastion-*`.

## Use it

The `bastion` module resolves the AMI automatically:

- Leave `bastion_ami_id` unset → it looks up the **latest** self-owned
  `cloudcart-bastion-*` AMI.
- Or pin a specific build: set `bastion_ami_id = "ami-0123..."` in the shared
  environment's tfvars for full reproducibility.

## CI: GitHub Actions

`.github/workflows/packer-bastion.yml` builds and registers the AMI:

- **Pull requests** touching `packer/**` → `packer fmt -check` + `packer validate` (no AWS needed).
- **Push to `main`** touching `packer/**`, or **manual `workflow_dispatch`** → `packer build` (registers the AMI in the account). The AMI is named `cloudcart-bastion-gh-<sha>` on push, or `cloudcart-bastion-<ami_version>` for a manual run.

Auth is via **GitHub OIDC** (no static AWS keys). One-time AWS setup:

1. Create the GitHub OIDC identity provider in the account
   (`token.actions.githubusercontent.com`).
2. Create an IAM role trusted by this repo's OIDC subject, with permissions to
   build an AMI: EC2 `RunInstances`/`StopInstances`/`TerminateInstances`,
   `CreateImage`/`RegisterImage`/`DeregisterImage`, `CreateSnapshot`,
   `CreateTags`, `DescribeImages`/`DescribeInstances`/`DescribeSubnets`/etc.,
   plus `CreateKeyPair`/`DeleteKeyPair` and `CreateSecurityGroup` (Packer's
   temporary resources). AWS publishes a "minimal Packer" policy you can base
   this on.

Then set these repo **Variables** (Settings → Secrets and variables → Actions):

| Variable | Purpose |
|---|---|
| `AWS_PACKER_ROLE_ARN` | ARN of the OIDC role to assume (required) |
| `AWS_REGION` | Build region (optional, default `us-west-2`) |
| `PACKER_SUBNET_ID` | Build subnet (optional; needs internet egress — omit to use the default VPC) |

The build instance needs internet egress to download tooling, so the build
subnet (or default VPC) must reach the internet. This is only at *build* time;
the resulting bastion still needs no egress.

## Order of operations

1. `packer build` the AMI — locally, or via the CI workflow (push to `main` /
   manual dispatch). Rebuild whenever you want to update tooling.
2. `terraform apply` the `shared` environment — the bastion launches from the
   latest baked AMI with no first-boot downloads.
