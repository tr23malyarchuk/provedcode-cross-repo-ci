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