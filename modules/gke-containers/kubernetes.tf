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
      app = var.deployment_name
    }
  }

  spec {
    replicas = var.replicas

    selector {
      match_labels = {
        app = var.deployment_name
      }
    }

    template {
      metadata {
        labels = {
          app = var.deployment_name
        }
      }

      spec {
        container {
          name  = var.container_name
          image = var.container_image

          port {
            container_port = var.container_port
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
      app = var.deployment_name
    }

    port {
      port        = var.service_port
      target_port = var.container_port
    }

    type = "LoadBalancer"
  }
}
