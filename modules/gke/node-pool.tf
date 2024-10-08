resource "google_container_node_pool" "default" {
  name     = var.node_pool_name
  location = var.region
  cluster  = google_container_cluster.default.name
  initial_node_count = var.node_count

  node_config {
    machine_type = "e2-small"
    disk_type = "pd-standard"

    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}
