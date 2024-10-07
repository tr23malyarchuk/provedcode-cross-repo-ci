resource "google_container_node_pool" "default" {
  name     = var.node_pool_name
  location = var.region
  cluster  = google_container_cluster.default.name

  node_config {
    machine_type = "e2-small"
    disk_size_gb = 10
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }

  initial_node_count = var.node_count
}
