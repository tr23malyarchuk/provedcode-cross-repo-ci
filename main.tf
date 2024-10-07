terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

provider "google" {
  project     = "zeta-sky-437510-j6"
  region      = "us-central1"
  credentials = file(var.credentials_path)
}

resource "google_container_cluster" "primary" {
  name     = "primary-cluster"
  location = "us-central1"

  initial_node_count = 1

  node_config {
    machine_type = "e2-small"
  }
}

module "backend" {
  source       = "./modules/backend"
  network_name = module.network.network_name
  db_user      = var.db_user
  db_password  = var.db_password
}

module "db" {
  source       = "./modules/db"
  network_name = module.network.network_name
  db_user      = var.db_user
  db_password  = var.db_password
}

module "frontend" {
  source       = "./modules/frontend"
  network_name = module.network.network_name
}

module "gke" {
  source          = "./modules/gke"
  project_id      = "zeta-sky-437510-j6"
  region          = var.region
  credentials_path = var.credentials_path
}

module "gke_containers" {
  source            = "./modules/gke-containers"
  credentials_path  = "zeta-sky-437510-j6-286cd01fd991.json"
  project_id        = "zeta-sky-437510-j6"
  region            = "us-central1"
  network_name      = "my-network"
  subnetwork_name   = "my-subnetwork"
  ip_cidr_range     = "10.0.0.0/16"
  cluster_name      = "my-cluster"
  node_count        = 3
  node_pool_name    = "my-node-pool"
  namespace_name    = "my-namespace"
  deployment_name   = "my-deployment"
  replicas          = 1
  container_name    = "my-container"
  container_image   = "my-container-image"
  container_port    = 80
  service_name      = "my-service"
  service_port      = 80
}

module "network" {
  source = "./modules/network"
}
