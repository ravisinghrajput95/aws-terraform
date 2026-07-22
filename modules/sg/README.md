<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_sg"></a> [sg](#module\_sg) | terraform-aws-modules/security-group/aws | ~> 4.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_region"></a> [region](#input\_region) | AWS region to deploy our resources | `string` | `"us-west-2"` | no |
| <a name="input_ssh_ingress_cidrs"></a> [ssh\_ingress\_cidrs](#input\_ssh\_ingress\_cidrs) | CIDRs allowed to SSH (port 22) to the bastion. Empty list disables SSH ingress entirely (rely on SSM Session Manager). | `list(string)` | `[]` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | CIDR block for the VPC | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | vpc id for the bastion | `string` | n/a | yes |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | name of the vpc | `string` | `"cloudcart-vpc"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_security_group_arn"></a> [security\_group\_arn](#output\_security\_group\_arn) | n/a |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | n/a |
<!-- END_TF_DOCS -->