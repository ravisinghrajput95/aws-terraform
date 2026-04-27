# Combine all repository ARNs into a list
locals {
  repository_image_tag_mutability = "MUTABLE"
  repository_image_scan_on_push   = true
  pull_only_users                 = ["Dev", "QA"]     # Replace with your actual pull users
  pull_push_users                 = ["DevOps", "SRE"] # Replace with your actual push/pull users
  pull_only_group_name            = "ECRPullGroup"
  pull_push_group_name            = "ECRPushPullGroup"

  ecr_repository_arns = [
    for repo in data.aws_ecr_repository.repos : repo.arn
  ]
}