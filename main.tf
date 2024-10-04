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
