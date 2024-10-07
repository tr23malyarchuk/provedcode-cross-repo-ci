resource "kubernetes_deployment" "my_app" {
  metadata {
    name      = var.deployment_name
    namespace = kubernetes_namespace.my_namespace.metadata[0].name
    labels = {
      app = "my-app"
    }
  }

  spec {
    replicas = var.replicas

    selector {
      match_labels = {
        app = "my-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "my-app"
        }
      }

      spec {
        container {
          name  = var.container_name
          image = var.container_image

          port {
            container_port = var.container_port  # Use 'port' instead of 'ports'
          }
        }
      }
    }
  }
}