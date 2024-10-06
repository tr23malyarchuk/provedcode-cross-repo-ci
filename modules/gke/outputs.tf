output "kubernetes_cluster_endpoint" {
  value = google_container_cluster.default.endpoint
}

output "service_external_ip" {
  value = kubernetes_service.my_app_service.status[0].load_balancer[0].ingress[0].ip
}
