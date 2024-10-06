terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.0"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}
provider "google" {
  project = "your-project-id"
  region  = "us-central1"
}

resource "google_container_cluster" "primary" {
  name     = "primary-cluster"
  location = "us-central1"

  initial_node_count = 1

  node_config {
    machine_type = "e2-medium" # 1 vCPU
  }
}

module "network" {
  source = "./modules/network"
}

module "db" {
  source = "./modules/db"
  network_name = module.network.network_name
  db_user = var.db_user
  db_password = var.db_password
}

module "backend" {
  source = "./modules/backend"
  network_name = module.network.network_name
  db_user = var.db_user
  db_password = var.db_password
}

module "frontend" {
  source = "./modules/frontend"
  network_name = module.network.network_name
}
