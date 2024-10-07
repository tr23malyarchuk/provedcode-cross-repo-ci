resource "google_compute_network" "default" {
  name                    = var.network_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "default" {
  name          = var.subnetwork_name
  ip_cidr_range = var.ip_cidr_range
  region        = var.region
  network       = google_compute_network.default.name
}