output "ecr_repository_arns" {
  description = "ARNs of the created ECR repositories"
  value = {
    for repo_name, repo in data.aws_ecr_repository.repos :
    repo_name => repo.arn
  }
}

output "ecr_pull_policy_arn" {
  description = "ARN of the IAM policy for ECR pull actions"
  value       = aws_iam_policy.ecr_pull_policy.arn
}

output "ecr_push_policy_arn" {
  description = "ARN of the IAM policy for ECR push actions"
  value       = aws_iam_policy.ecr_push_policy.arn
}

output "ecr_pull_group_name" {
  description = "Name of the IAM group for pull-only access to ECR"
  value       = aws_iam_group.ecr_pull_group.name
}

output "ecr_push_pull_group_name" {
  description = "Name of the IAM group for push and pull access to ECR"
  value       = aws_iam_group.ecr_push_pull_group.name
}

output "ecr_pull_group_users" {
  description = "Users assigned to the pull-only group for ECR"
  value       = local.pull_only_users
}

output "ecr_push_pull_group_users" {
  description = "Users assigned to the push and pull group for ECR"
  value       = local.pull_push_users
}
