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
| [aws_cloudwatch_dashboard.rds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_dashboard) | resource |
| [aws_cloudwatch_metric_alarm.rds_connections](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.rds_cpu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.rds_free_storage](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_sns_topic.alerts](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_sns_topic_subscription.email](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alarm_email"></a> [alarm\_email](#input\_alarm\_email) | Email to subscribe to the alerts topic (empty = no subscription) | `string` | `""` | no |
| <a name="input_db_instance_id"></a> [db\_instance\_id](#input\_db\_instance\_id) | RDS instance identifier to alarm on | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name (used in resource names) | `string` | n/a | yes |
| <a name="input_rds_connections_threshold"></a> [rds\_connections\_threshold](#input\_rds\_connections\_threshold) | RDS connection-count alarm threshold | `number` | `100` | no |
| <a name="input_rds_cpu_threshold"></a> [rds\_cpu\_threshold](#input\_rds\_cpu\_threshold) | RDS CPU% alarm threshold | `number` | `80` | no |
| <a name="input_rds_free_storage_bytes"></a> [rds\_free\_storage\_bytes](#input\_rds\_free\_storage\_bytes) | RDS free storage alarm threshold (bytes) | `number` | `5368709120` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dashboard_name"></a> [dashboard\_name](#output\_dashboard\_name) | CloudWatch dashboard name |
| <a name="output_sns_topic_arn"></a> [sns\_topic\_arn](#output\_sns\_topic\_arn) | ARN of the alerts SNS topic |
<!-- END_TF_DOCS -->