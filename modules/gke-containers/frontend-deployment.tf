resource "kubernetes_deployment" "frontend_deployment" {
  metadata {
    name = "frontend-app"
    labels = {
      app = "frontend"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "frontend"
      }
    }

    template {
      metadata {
        labels = {
          app = "frontend"
        }
      }

      spec {
        container {
          name  = "frontend"
          image = "tr23malyarchuk/frontginx:v1"

          port {
            container_port = 80
          }
        }
      }
    }
  }
}
