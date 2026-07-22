module "ecr" {
  source          = "terraform-aws-modules/ecr/aws"
  version         = "~> 2.0"
  for_each        = toset(var.repository_names)
  repository_name = "cloudcart-${each.key}"

  repository_image_scan_on_push   = local.repository_image_scan_on_push
  repository_image_tag_mutability = local.repository_image_tag_mutability

  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last 30 images",
        selection = {
          tagStatus     = "tagged",
          tagPrefixList = ["dev", "qa", "stage", "release"],
          countType     = "imageCountMoreThan",
          countNumber   = 30
        },
        action = {
          type = "expire"
        }
      }
    ]
  })

  tags = {
    Environment = var.environment
  }
}

# Create IAM policies for pull actions
resource "aws_iam_policy" "ecr_pull_policy" {
  name        = "cloudcart-ECRPullPolicy"
  description = "Policy to allow pulling images from ECR repositories"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability"
        ]
        Resource = local.ecr_repository_arns
      }
    ]
  })
}

# Create IAM policies for push actions
resource "aws_iam_policy" "ecr_push_policy" {
  name        = "cloudcart-ECRPushPolicy"
  description = "Policy to allow pushing images to ECR repositories"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ecr:PutImage",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload"
        ]
        Resource = local.ecr_repository_arns
      }
    ]
  })
}

# Create IAM group for pull-only access
resource "aws_iam_group" "ecr_pull_group" {
  name = local.pull_only_group_name
}

# Attach pull policy to the pull-only group
resource "aws_iam_group_policy_attachment" "ecr_pull_group_attachment" {
  group      = aws_iam_group.ecr_pull_group.name
  policy_arn = aws_iam_policy.ecr_pull_policy.arn
}

# Create IAM group for push and pull access
resource "aws_iam_group" "ecr_push_pull_group" {
  name = local.pull_push_group_name
}

# Attach pull policy to the push and pull group
resource "aws_iam_group_policy_attachment" "ecr_push_pull_group_pull_attachment" {
  group      = aws_iam_group.ecr_push_pull_group.name
  policy_arn = aws_iam_policy.ecr_pull_policy.arn
}

# Attach push policy to the push and pull group
resource "aws_iam_group_policy_attachment" "ecr_push_pull_group_push_attachment" {
  group      = aws_iam_group.ecr_push_pull_group.name
  policy_arn = aws_iam_policy.ecr_push_policy.arn
}

# Assign users to the pull-only group
resource "aws_iam_user_group_membership" "pull_only_group_membership" {
  for_each = toset(local.pull_only_users)
  user     = each.key
  groups   = [aws_iam_group.ecr_pull_group.name]
}

# Assign users to the push and pull group
resource "aws_iam_user_group_membership" "push_pull_group_membership" {
  for_each = toset(local.pull_push_users)
  user     = each.key
  groups   = [aws_iam_group.ecr_push_pull_group.name]
}
