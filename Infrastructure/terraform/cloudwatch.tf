resource "aws_cloudwatch_log_group" "eks_logs" {
  name              = "/aws/eks/${var.project_name}-cluster/cluster"
  retention_in_days = 3
}