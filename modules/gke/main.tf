# Configure the Google Cloud Provider
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

provider "google" {
  credentials = file(var.credentials_path) # Use a variable for the credentials file path
  project     = var.project_id             # Use a variable for the project ID
  region      = var.region                 # Use a variable for the region
}

# Create a VPC Network
resource "google_compute_network" "default" {
  name                    = var.network_name # Use a variable for the network name
  auto_create_subnetworks = false
}

# Create a Subnetwork
resource "google_compute_subnetwork" "default" {
  name          = var.subnetwork_name  # Use a variable for the subnetwork name
  ip_cidr_range = var.ip_cidr_range    # Use a variable for the CIDR range
  region        = var.region
  network       = google_compute_network.default.name
}

# Create a Kubernetes Engine Cluster
resource "google_container_cluster" "default" {
  name             = var.cluster_name     # Use a variable for the cluster name
  location         = var.region
  initial_node_count = var.node_count     # Use a variable for the node count

  node_config {
    machine_type = var.machine_type       # Use a variable for the machine type
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
  network    = google_compute_network.default.name
  subnetwork = google_compute_subnetwork.default.name

  # Enable the Kubernetes Engine add-on for the cluster
  addons_config {
    http_load_balancing {
      disabled = false
    }
  }
}

# Create a Kubernetes Engine Node Pool
resource "google_container_node_pool" "default" {
  name     = var.node_pool_name            # Use a variable for the node pool name
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

# Create a Kubernetes Engine Namespace
resource "kubernetes_namespace" "my_namespace" {
  metadata {
    name = var.namespace_name # Use a variable for the namespace name
  }
}

# Create a Kubernetes Deployment
resource "kubernetes_deployment" "my_app" {
  metadata {
    name      = var.deployment_name   # Use a variable for the deployment name
    namespace = kubernetes_namespace.my_namespace.metadata[0].name
    labels = {
      app = "my-app"
    }
  }

  spec {
    replicas = var.replicas           # Use a variable for the number of replicas

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
          name  = var.container_name   # Use a variable for the container name
          image = var.container_image  # Use a variable for the container image
          ports {
            container_port = var.container_port  # Use a variable for the container port
          }
        }
      }
    }
  }
}

# Create a Kubernetes Service to expose the Deployment
resource "kubernetes_service" "my_app_service" {
  metadata {
    name      = var.service_name      # Use a variable for the service name
    namespace = kubernetes_namespace.my_namespace.metadata[0].name
  }

  spec {
    selector = {
      app = "my-app"
    }

    port {
      port        = var.service_port   # Use a variable for the service port
      target_port = var.container_port
    }

    type = "LoadBalancer"
  }
}
