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
| [aws_route.accepter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.requester](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_vpc_peering_connection.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_peering_connection) | resource |
| [aws_vpc_peering_connection_options.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_peering_connection_options) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_accepter_cidr"></a> [accepter\_cidr](#input\_accepter\_cidr) | CIDR of the accepter (spoke) VPC | `string` | n/a | yes |
| <a name="input_accepter_route_table_ids"></a> [accepter\_route\_table\_ids](#input\_accepter\_route\_table\_ids) | Route tables on the accepter side that need a route back to the requester CIDR | `list(string)` | n/a | yes |
| <a name="input_accepter_vpc_id"></a> [accepter\_vpc\_id](#input\_accepter\_vpc\_id) | VPC ID on the accepter side (a spoke/environment VPC) | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name tag for the peering connection | `string` | n/a | yes |
| <a name="input_requester_cidr"></a> [requester\_cidr](#input\_requester\_cidr) | CIDR of the requester (hub) VPC | `string` | n/a | yes |
| <a name="input_requester_route_table_ids"></a> [requester\_route\_table\_ids](#input\_requester\_route\_table\_ids) | Route tables on the requester side that need a route to the accepter CIDR | `list(string)` | n/a | yes |
| <a name="input_requester_vpc_id"></a> [requester\_vpc\_id](#input\_requester\_vpc\_id) | VPC ID on the requester side (the shared/hub VPC) | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to the peering connection | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_peering_connection_id"></a> [peering\_connection\_id](#output\_peering\_connection\_id) | ID of the VPC peering connection |
<!-- END_TF_DOCS -->