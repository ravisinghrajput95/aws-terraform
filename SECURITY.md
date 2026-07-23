# Security

## Reporting

Report suspected vulnerabilities privately to the platform team (do not open a
public issue). Include affected config/module and reproduction steps.

## Baseline controls in this repo

- **No secrets in git.** DB credentials are generated into AWS Secrets Manager;
  `*.tfvars` and `*.tfstate` are git-ignored.
- **Encryption at rest.** RDS and S3 state buckets are encrypted; CloudTrail logs
  use a customer-managed KMS key.
- **State buckets** are versioned, public-access-blocked, and TLS-only.
- **Detection.** CloudTrail, AWS Config, GuardDuty, Security Hub, IAM Access
  Analyzer, and VPC Flow Logs are enabled.
- **Access.** The bastion is private and SSM-only (no public IP, no key pair);
  EKS API endpoints are private; IAM is least-privilege.
- **CI scanning.** checkov and trivy run on every PR (SARIF → code scanning).

## Secrets exposure

If a secret is ever committed: rotate it immediately, then purge it from history.
Git-ignore rules alone are not sufficient once something is committed.
