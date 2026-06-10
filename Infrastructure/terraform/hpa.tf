resource "kubernetes_horizontal_pod_autoscaler_v2" "despacho_hpa" {
  metadata {
    name      = "hpa-despacho-${var.project_name}"
    namespace = "default"
  }

  spec {
    min_replicas = 2
    max_replicas = 10

    scale_target_ref {
      api_version = "apps/v1"
      kind        = "Deployment"
      name        = "deployment-despacho"
    }

    metric {
      type = "Resource"
      resource {
        name = "cpu"
        target {
          type               = "Utilization"
          average_utilization = 70
        }
      }
    }

    metric {
      type = "Resource"
      resource {
        name = "memory"
        target {
          type               = "Utilization"
          average_utilization = 80
        }
      }
    }
  }
  
  depends_on = [helm_release.metrics_server]
}

resource "kubernetes_horizontal_pod_autoscaler_v2" "ventas_hpa" {
  metadata {
    name      = "hpa-ventas-${var.project_name}"
    namespace = "default"
  }

  spec {
    min_replicas = 2
    max_replicas = 10

    scale_target_ref {
      api_version = "apps/v1"
      kind        = "Deployment"
      name        = "deployment-ventas"
    }

    metric {
      type = "Resource"
      resource {
        name = "cpu"
        target {
          type               = "Utilization"
          average_utilization = 70
        }
      }
    }
  }

  depends_on = [helm_release.metrics_server]
}

resource "kubernetes_horizontal_pod_autoscaler_v2" "frontend_hpa" {
  metadata {
    name      = "hpa-frontend-${var.project_name}"
    namespace = "default"
  }

  spec {
    min_replicas = 2
    max_replicas = 5

    scale_target_ref {
      api_version = "apps/v1"
      kind        = "Deployment"
      name        = "deployment-frontend"
    }

    metric {
      type = "Resource"
      resource {
        name = "cpu"
        target {
          type               = "Utilization"
          average_utilization = 75
        }
      }
    }
  }

  depends_on = [helm_release.metrics_server]
}
