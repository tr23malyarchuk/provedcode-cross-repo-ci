resource "google_container_cluster" "default" {
  name               = var.cluster_name
  location           = var.region
  initial_node_count = 3

  node_config {
    machine_type = "e2-small"
  }

  network    = var.network_name
  subnetwork = var.subnetwork_name
}
