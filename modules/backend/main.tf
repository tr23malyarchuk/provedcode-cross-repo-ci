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

resource "docker_image" "backend_image" {
  name = "tr23malyarchuk/mavenback:v2"
}

resource "docker_container" "backend" {
  name    = "backend"
  image   = docker_image.backend_image.name
  restart = "always"

  env = [
    "SPRING_PROFILES_ACTIVE=prod",
    "SPRING_DATASOURCE_URL=jdbc:postgresql://db:5432/provedcode",
    "SPRING_DATASOURCE_USERNAME=${var.db_user}",
    "SPRING_DATASOURCE_PASSWORD=${var.db_password}"
  ]

  ports {
    internal = 8080
    external = 8080
  }

  networks_advanced {
    name = var.network_name
  }
}
