resource "kubernetes_namespace_v1" "app" {
  metadata {
    name = "gcp-sandbox-app"
  }
}

resource "kubernetes_deployment_v1" "app" {
  metadata {
    name      = "gcp-sandbox-app"
    namespace = kubernetes_namespace_v1.app.metadata[0].name
    labels = {
      "app.kubernetes.io/name" = "gcp-sandbox-app"
    }
  }

  spec {
    replicas = var.replicas

    selector {
      match_labels = {
        "app.kubernetes.io/name" = "gcp-sandbox-app"
      }
    }

    template {
      metadata {
        labels = {
          "app.kubernetes.io/name" = "gcp-sandbox-app"
        }
      }

      spec {
        container {
          name              = "app"
          image             = var.image
          image_pull_policy = "IfNotPresent"

          port {
            name           = "http"
            container_port = 8000
            protocol       = "TCP"
          }

          readiness_probe {
            http_get {
              path = "/"
              port = "http"
            }
            initial_delay_seconds = 2
            period_seconds        = 5
          }

          liveness_probe {
            http_get {
              path = "/"
              port = "http"
            }
            initial_delay_seconds = 5
            period_seconds        = 10
          }

          resources {
            requests = {
              cpu    = "50m"
              memory = "64Mi"
            }
            limits = {
              cpu    = "250m"
              memory = "128Mi"
            }
          }

          security_context {
            allow_privilege_escalation = false
            read_only_root_filesystem  = true
            run_as_non_root            = true
            run_as_user                = 10001

            capabilities {
              drop = ["ALL"]
            }

            seccomp_profile {
              type = "RuntimeDefault"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service_v1" "app" {
  metadata {
    name      = "gcp-sandbox-app"
    namespace = kubernetes_namespace_v1.app.metadata[0].name
  }

  spec {
    selector = {
      "app.kubernetes.io/name" = "gcp-sandbox-app"
    }

    port {
      name        = "http"
      port        = 80
      target_port = "http"
      protocol    = "TCP"
    }

    type = "ClusterIP"
  }

  lifecycle {
    ignore_changes = [
      metadata[0].annotations["cloud.google.com/neg"],
    ]
  }
}
