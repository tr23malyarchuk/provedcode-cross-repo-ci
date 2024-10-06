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
    machine_type = "e2-medium" # 1 vCPU
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
  source = "./modules/gke-containers"
}

module "network" {
  source = "./modules/network"
}
