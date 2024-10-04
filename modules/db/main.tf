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

resource "docker_image" "db_image" {
  name = "postgres:13"
}

resource "docker_volume" "db_data" {
  name = "db_data"
}

resource "docker_container" "db" {
  name    = "db"
  image   = docker_image.db_image.name
  restart = "always"

  env = [
    "POSTGRES_DB=provedcode",
    "POSTGRES_USER=${var.db_user}",
    "POSTGRES_PASSWORD=${var.db_password}"
  ]

  ports {
    internal = 5432
    external = 5432
  }

  volumes {
    volume_name    = docker_volume.db_data.name
    container_path = "/var/lib/postgresql/data"
  }

  networks_advanced {
    name = var.network_name
  }
}
