resource "aws_cloudwatch_log_group" "eks_logs" {
  name              = "/eks/${var.project_name}/logs"
  retention_in_days = 3
}