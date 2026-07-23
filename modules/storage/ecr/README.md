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
| <a name="module_ecr"></a> [ecr](#module\_ecr) | terraform-aws-modules/ecr/aws | ~> 2.0 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_group.ecr_pull_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group) | resource |
| [aws_iam_group.ecr_push_pull_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group) | resource |
| [aws_iam_group_policy_attachment.ecr_pull_group_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachment) | resource |
| [aws_iam_group_policy_attachment.ecr_push_pull_group_pull_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachment) | resource |
| [aws_iam_group_policy_attachment.ecr_push_pull_group_push_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachment) | resource |
| [aws_iam_policy.ecr_pull_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.ecr_push_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_user_group_membership.pull_only_group_membership](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_group_membership) | resource |
| [aws_iam_user_group_membership.push_pull_group_membership](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_group_membership) | resource |
| [aws_ecr_repository.repos](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ecr_repository) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | The environment to provision the resources | `any` | n/a | yes |
| <a name="input_repository_names"></a> [repository\_names](#input\_repository\_names) | The names of the ECR repositories | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ecr_pull_group_name"></a> [ecr\_pull\_group\_name](#output\_ecr\_pull\_group\_name) | Name of the IAM group for pull-only access to ECR |
| <a name="output_ecr_pull_group_users"></a> [ecr\_pull\_group\_users](#output\_ecr\_pull\_group\_users) | Users assigned to the pull-only group for ECR |
| <a name="output_ecr_pull_policy_arn"></a> [ecr\_pull\_policy\_arn](#output\_ecr\_pull\_policy\_arn) | ARN of the IAM policy for ECR pull actions |
| <a name="output_ecr_push_policy_arn"></a> [ecr\_push\_policy\_arn](#output\_ecr\_push\_policy\_arn) | ARN of the IAM policy for ECR push actions |
| <a name="output_ecr_push_pull_group_name"></a> [ecr\_push\_pull\_group\_name](#output\_ecr\_push\_pull\_group\_name) | Name of the IAM group for push and pull access to ECR |
| <a name="output_ecr_push_pull_group_users"></a> [ecr\_push\_pull\_group\_users](#output\_ecr\_push\_pull\_group\_users) | Users assigned to the push and pull group for ECR |
| <a name="output_ecr_repository_arns"></a> [ecr\_repository\_arns](#output\_ecr\_repository\_arns) | ARNs of the created ECR repositories |
<!-- END_TF_DOCS -->