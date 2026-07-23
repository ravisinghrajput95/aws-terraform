resource "aws_accessanalyzer_analyzer" "this" {
  analyzer_name = var.name
  type          = var.type
  tags          = var.tags
}
