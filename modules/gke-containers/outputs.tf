output "frontend_deployment_name" {
  value = kubernetes_deployment.frontend_deployment.metadata[0].name
}

output "backend_deployment_name" {
  value = kubernetes_deployment.backend_deployment.metadata[0].name
}
