output "cluster_endpoint" {
  description = "The endpoint for the Kubernetes cluster"
  value       = google_container_cluster.primary.endpoint
}

output "network_name" {
  description = "The name of the created network"
  value       = module.network.network_name
}
