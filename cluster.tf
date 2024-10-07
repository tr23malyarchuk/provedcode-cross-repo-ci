resource "google_container_cluster" "primary" {
  name     = "primary-cluster"
  location = var.region

  initial_node_count = 3

  node_config {
    machine_type = "e2-small"
  }
}
