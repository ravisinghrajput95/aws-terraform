<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |
| <a name="provider_random"></a> [random](#provider\_random) | ~> 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_secretsmanager_secret.db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [random_password.db](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | Environment the secret belongs to (dev, qa, stage, production) | `string` | n/a | yes |
| <a name="input_password_length"></a> [password\_length](#input\_password\_length) | Length of the generated master password | `number` | `24` | no |
| <a name="input_recovery_window_in_days"></a> [recovery\_window\_in\_days](#input\_recovery\_window\_in\_days) | Days AWS retains the secret after deletion before permanent removal (0 for immediate delete, useful in non-prod) | `number` | `7` | no |
| <a name="input_secret_name"></a> [secret\_name](#input\_secret\_name) | Optional override for the Secrets Manager secret name. Defaults to cloudcart-<env>-db-password | `string` | `""` | no |
| <a name="input_username"></a> [username](#input\_username) | Master DB username stored alongside the generated password | `string` | `"cloudcart_user"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_password"></a> [password](#output\_password) | Generated master DB password |
| <a name="output_secret_arn"></a> [secret\_arn](#output\_secret\_arn) | ARN of the Secrets Manager secret holding the DB credentials |
| <a name="output_secret_name"></a> [secret\_name](#output\_secret\_name) | Name of the Secrets Manager secret |
| <a name="output_secret_version_id"></a> [secret\_version\_id](#output\_secret\_version\_id) | Version ID of the stored secret value |
| <a name="output_username"></a> [username](#output\_username) | Master DB username stored in the secret |
<!-- END_TF_DOCS -->