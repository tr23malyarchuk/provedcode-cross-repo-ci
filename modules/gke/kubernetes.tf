resource "kubernetes_namespace" "my_namespace" {
  metadata {
    name = var.namespace_name
  }

  depends_on = [google_container_cluster.default]
}

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

resource "kubernetes_service" "my_app_service" {
  metadata {
    name      = var.service_name
    namespace = kubernetes_namespace.my_namespace.metadata[0].name
  }

  spec {
    selector = {
      app = "my-app"
    }

    port {
      port        = var.service_port
      target_port = var.container_port
    }

    type = "LoadBalancer"
  }
}
