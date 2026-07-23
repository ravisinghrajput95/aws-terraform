# Example: VPC module

Minimal usage of `modules/vpc`.

```bash
cd examples/vpc
terraform init
terraform plan
```

Shows a single-NAT `/16` VPC with flow logs. Uncomment the overrides in
`main.tf` for per-AZ NAT or to tune flow logs.
