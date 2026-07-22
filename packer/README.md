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

## Order of operations

1. `packer build` the AMI (once, and whenever you want to update tooling).
2. `terraform apply` the `shared` environment — the bastion launches from the
   baked AMI with no first-boot downloads.
