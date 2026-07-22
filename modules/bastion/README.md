<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_bastion"></a> [bastion](#module\_bastion) | terraform-aws-modules/ec2-instance/aws | ~> 5.0 |

## Resources

| Name | Type |
|------|------|
| [aws_eip.bastion](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_ami.bastion](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami_id"></a> [ami\_id](#input\_ami\_id) | AMI ID for the bastion. Empty looks up the latest self-owned cloudcart-bastion-* AMI built by Packer (packer/). | `string` | `""` | no |
| <a name="input_associate_public_ip"></a> [associate\_public\_ip](#input\_associate\_public\_ip) | Whether to give the bastion a public IP. Keep false for a private, SSM-only bastion. | `bool` | `false` | no |
| <a name="input_create_eip"></a> [create\_eip](#input\_create\_eip) | Whether to allocate and attach an Elastic IP (only relevant for a public bastion). | `bool` | `false` | no |
| <a name="input_iam_role_name"></a> [iam\_role\_name](#input\_iam\_role\_name) | n/a | `string` | `""` | no |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | EC2 key pair for SSH. Empty means no key pair (SSM-only access). | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region to deploy our resources | `string` | `"us-west-2"` | no |
| <a name="input_security_group_id"></a> [security\_group\_id](#input\_security\_group\_id) | n/a | `string` | `""` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | Subnets to place the bastion in (first is used). Use private subnets for an SSM-only bastion. | `list(string)` | `[]` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | CIDR block for the VPC | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | vpc id for the bastion | `string` | n/a | yes |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | name of the vpc | `string` | `"cloudcart"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bastion_complete_arn"></a> [bastion\_complete\_arn](#output\_bastion\_complete\_arn) | The ARN of the instance |
| <a name="output_bastion_complete_ebs_block_device"></a> [bastion\_complete\_ebs\_block\_device](#output\_bastion\_complete\_ebs\_block\_device) | EBS block device information |
| <a name="output_bastion_complete_id"></a> [bastion\_complete\_id](#output\_bastion\_complete\_id) | The ID of the instance |
| <a name="output_bastion_complete_private_ip"></a> [bastion\_complete\_private\_ip](#output\_bastion\_complete\_private\_ip) | The private IP address of the instance |
| <a name="output_bastion_complete_public_ip"></a> [bastion\_complete\_public\_ip](#output\_bastion\_complete\_public\_ip) | The public IP address of the instance (null for a private SSM-only bastion) |
| <a name="output_bastion_complete_root_block_device"></a> [bastion\_complete\_root\_block\_device](#output\_bastion\_complete\_root\_block\_device) | Root block device information |
<!-- END_TF_DOCS -->