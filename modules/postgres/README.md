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

| Name | Source | Version |
|------|--------|---------|
| <a name="module_postgres"></a> [postgres](#module\_postgres) | terraform-aws-modules/rds/aws | ~> 5.0 |
| <a name="module_security_group"></a> [security\_group](#module\_security\_group) | terraform-aws-modules/security-group/aws | ~> 5.0 |

## Resources

| Name | Type |
|------|------|
| [aws_db_instance.read_replica](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bastion_cidr"></a> [bastion\_cidr](#input\_bastion\_cidr) | CIDR of the shared bastion VPC allowed to reach the DB over peering (empty to disable) | `string` | `""` | no |
| <a name="input_cidr_blocks"></a> [cidr\_blocks](#input\_cidr\_blocks) | CIDR blocks of VPC subnet | `string` | n/a | yes |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | n/a | `string` | `"cloudcartdevdb"` | no |
| <a name="input_enable_enhanced_monitoring"></a> [enable\_enhanced\_monitoring](#input\_enable\_enhanced\_monitoring) | Enable RDS Enhanced Monitoring (creates a monitoring IAM role) | `bool` | `true` | no |
| <a name="input_enable_performance_insights"></a> [enable\_performance\_insights](#input\_enable\_performance\_insights) | Enable RDS Performance Insights | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment for which VPC is being created (dev, qa, staging, production) | `string` | n/a | yes |
| <a name="input_monitoring_interval"></a> [monitoring\_interval](#input\_monitoring\_interval) | Enhanced Monitoring interval in seconds (1,5,10,15,30,60) | `number` | `60` | no |
| <a name="input_password"></a> [password](#input\_password) | Master user password for the RDS DB instance | `string` | n/a | yes |
| <a name="input_performance_insights_retention_period"></a> [performance\_insights\_retention\_period](#input\_performance\_insights\_retention\_period) | Performance Insights retention in days (7 = free tier, or 731) | `number` | `7` | no |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | Private subnet ids to provision RDS Postgres instance | `list(string)` | n/a | yes |
| <a name="input_username"></a> [username](#input\_username) | n/a | `string` | `"cloudcart_user"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_db_instance_address"></a> [db\_instance\_address](#output\_db\_instance\_address) | n/a |
| <a name="output_db_instance_arn"></a> [db\_instance\_arn](#output\_db\_instance\_arn) | The ARN of the RDS instance |
| <a name="output_db_instance_availability_zone"></a> [db\_instance\_availability\_zone](#output\_db\_instance\_availability\_zone) | The availability zone of the RDS instance |
| <a name="output_db_instance_endpoint"></a> [db\_instance\_endpoint](#output\_db\_instance\_endpoint) | n/a |
| <a name="output_db_instance_name"></a> [db\_instance\_name](#output\_db\_instance\_name) | n/a |
| <a name="output_db_parameter_group_id"></a> [db\_parameter\_group\_id](#output\_db\_parameter\_group\_id) | n/a |
| <a name="output_db_subnet_group_id"></a> [db\_subnet\_group\_id](#output\_db\_subnet\_group\_id) | n/a |
| <a name="output_read_replica_address"></a> [read\_replica\_address](#output\_read\_replica\_address) | n/a |
| <a name="output_read_replica_allocated_storage"></a> [read\_replica\_allocated\_storage](#output\_read\_replica\_allocated\_storage) | n/a |
| <a name="output_read_replica_endpoint"></a> [read\_replica\_endpoint](#output\_read\_replica\_endpoint) | n/a |
| <a name="output_read_replica_instance_class"></a> [read\_replica\_instance\_class](#output\_read\_replica\_instance\_class) | n/a |
<!-- END_TF_DOCS -->