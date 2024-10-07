output "cluster_endpoint" {
  description = "The GKE cluster endpoint"
  value       = google_container_cluster.default.endpoint
}

output "cluster_name" {
  description = "The GKE cluster name"
  value       = google_container_cluster.default.name
}
