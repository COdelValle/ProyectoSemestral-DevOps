resource "aws_cloudwatch_log_group" "eks_logs" {
  name              = "/aws/containerinsights/tu-cluster-eks/application"
  retention_in_days = 3 # Retención baja para ahorrar créditos de AWS Academy
}

resource "helm_release" "fluent_bit" {
  name       = "fluent-bit"
  repository = "https://github.io"
  chart      = "aws-for-fluent-bit"
  namespace  = "logging"
  create_namespace = true

  set {
    name  = "cloudWatchLogs.enabled"
    value = "true"
  }

  set {
    name  = "cloudWatchLogs.region"
    value = "us-east-1" # Región típica de AWS Academy
  }

  set {
    name  = "cloudWatchLogs.logGroupName"
    value = aws_cloudwatch_log_group.eks_logs.name
  }

  set {
    name  = "cloudWatchLogs.autoCreateStream"
    value = "true"
  }
}