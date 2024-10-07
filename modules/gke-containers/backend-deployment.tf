resource "kubernetes_deployment" "backend_deployment" {
  metadata {
    name = "backend-app"
    labels = {
      app = "backend"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "backend"
      }
    }

    template {
      metadata {
        labels = {
          app = "backend"
        }
      }

      spec {
        container {
          name  = "backend"
          image = "tr23malyarchuk/mavenback:v2"

          port {
            container_port = 8080
          }
        }
      }
    }
  }
}
