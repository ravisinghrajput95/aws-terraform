<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_accessanalyzer_analyzer.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/accessanalyzer_analyzer) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | Analyzer name | `string` | `"cloudcart-analyzer"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags | `map(string)` | `{}` | no |
| <a name="input_type"></a> [type](#input\_type) | Analyzer type: ACCOUNT or ORGANIZATION (also *\_UNUSED\_ACCESS variants) | `string` | `"ACCOUNT"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_analyzer_arn"></a> [analyzer\_arn](#output\_analyzer\_arn) | ARN of the Access Analyzer |
<!-- END_TF_DOCS -->