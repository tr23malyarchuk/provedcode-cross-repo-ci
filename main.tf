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

module "network" {
  source = "./modules/network"
}

module "database" {
  source = "./modules/database"
  network_name = module.network.network_name
}

module "backend" {
  source = "./modules/backend"
  network_name = module.network.network_name
  db_container_name = module.database.db_container_name
}

module "frontend" {
  source = "./modules/frontend"
  network_name = module.network.network_name
  backend_container_name = module.backend.backend_container_name
}
