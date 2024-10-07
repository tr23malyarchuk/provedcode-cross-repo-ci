provider "google" {
  credentials = var.credentials_path
  project     = var.project_id
  region      = var.region
}

provider "kubernetes" {
  host                   = google_container_cluster.default.endpoint
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(google_container_cluster.default.master_auth[0].cluster_ca_certificate)

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "gcloud"
    args        = ["container", "clusters", "get-credentials", data.google_container_cluster.primary.name, "--zone", data.google_container_cluster.primary.location]
  }
}

data "google_client_config" "default" {}

data "google_container_cluster" "primary" {
  name     = "primary-cluster"
  location = "us-central1"
}
