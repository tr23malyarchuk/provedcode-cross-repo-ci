terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

provider "google" {
  credentials = file(var.credentials_path)
  project     = var.project_id
  region      = var.region
}

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

resource "google_container_cluster" "default" {
  name             = var.cluster_name
  location         = var.region
  initial_node_count = var.node_count

  node_config {
    machine_type = var.machine_type
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
  network    = google_compute_network.default.name
  subnetwork = google_compute_subnetwork.default.name

  addons_config {
    http_load_balancing {
      disabled = false
    }
  }
}

resource "google_container_node_pool" "default" {
  name     = var.node_pool_name
  location = var.region
  cluster  = google_container_cluster.default.name
  initial_node_count = var.node_count

  node_config {
    machine_type = var.machine_type
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}

resource "kubernetes_namespace" "my_namespace" {
  metadata {
    name = var.namespace_name
  }
}

resource "kubernetes_deployment" "my_app" {
  metadata {
    name      = var.deployment_name
    namespace = kubernetes_namespace.my_namespace.metadata[0].name
    labels = {
      app = "my-app"
    }
  }

  spec {
    replicas = var.replicas

    selector {
      match_labels = {
        app = "my-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "my-app"
        }
      }

      spec {
        container {
          name  = var.container_name
          image = var.container_image
          ports {
            container_port = var.container_port
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "my_app_service" {
  metadata {
    name      = var.service_name
    namespace = kubernetes_namespace.my_namespace.metadata[0].name
  }

  spec {
    selector = {
      app = "my-app"
    }

    port {
      port        = var.service_port
      target_port = var.container_port
    }

    type = "LoadBalancer"
  }
}
