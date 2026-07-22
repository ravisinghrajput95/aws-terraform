# CloudCart — AWS Terraform (Multiple Environments)

Terraform configuration that provisions CloudCart's AWS infrastructure across
`dev`, `qa`, `stage`, and `production` from a shared set of modules (VPC, EKS,
RDS Postgres, ECR, bastion, security groups, IAM). All provisioned resources
are named with the `cloudcart` prefix.