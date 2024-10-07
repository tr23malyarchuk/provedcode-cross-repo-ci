resource "kubernetes_namespace" "my_namespace" {
  metadata {
    name = var.namespace_name
  }

  depends_on = [google_container_cluster.default]
}