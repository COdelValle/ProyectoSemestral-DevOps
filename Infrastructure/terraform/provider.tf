terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "helm_release" "fluent_bit" {
  name             = "fluent-bit"
  repository       = "https://aws.github.io/eks-charts"
  chart            = "aws-for-fluent-bit"
  namespace        = "logging"
  create_namespace = true

  set = [
    {
      name  = "cloudWatchLogs.enabled"
      value = "true"
    },
    {
      name  = "cloudWatchLogs.region"
      value = "us-east-1"
    },
    {
      name  = "cloudWatchLogs.logGroupName"
      value = aws_cloudwatch_log_group.eks_logs.name
    },
    {
      name  = "cloudWatchLogs.autoCreateStream"
      value = "true"
    },
    {
      name  = "serviceAccount.create"
      value = "true"
    },
    {
      name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
      value = data.aws_iam_role.labrole.arn
    }
  ]
}

resource "helm_release" "metrics_server" {
  name             = "metrics-server"
  repository       = "https://kubernetes-sigs.github.io/metrics-server/"
  chart            = "metrics-server"
  namespace        = "kube-system"
  create_namespace = false
  
  set = [
    {
      name  = "args[0]"
      value = "--kubelet-insecure-tls"
    }
  ]
}