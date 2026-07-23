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
| [aws_securityhub_account.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/securityhub_account) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auto_enable_controls"></a> [auto\_enable\_controls](#input\_auto\_enable\_controls) | Automatically enable new controls as standards are updated | `bool` | `true` | no |
| <a name="input_control_finding_generator"></a> [control\_finding\_generator](#input\_control\_finding\_generator) | How controls generate findings: SECURITY\_CONTROL or STANDARD\_CONTROL | `string` | `"SECURITY_CONTROL"` | no |
| <a name="input_enable_default_standards"></a> [enable\_default\_standards](#input\_enable\_default\_standards) | Subscribe to the AWS default standards (Foundational Security Best Practices, CIS) | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_account_id"></a> [account\_id](#output\_account\_id) | Security Hub account resource ID |
<!-- END_TF_DOCS -->