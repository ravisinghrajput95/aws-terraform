# Use data blocks to retrieve the ARNs of the created ECR repositories
data "aws_ecr_repository" "repos" {
  for_each = toset(var.repository_names)
  name     = "cloudcart-${each.key}"

  depends_on = [module.ecr]
}

