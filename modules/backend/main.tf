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
    "SPRING_DATASOURCE_URL=jdbc:postgresql://${var.db_container_name}:5432/provedcode",
    "SPRING_DATASOURCE_USERNAME=app_user",
    "SPRING_DATASOURCE_PASSWORD=app_pass"
  ]

  ports {
    internal = 8080
    external = 8080
  }

  depends_on = [var.db_container_name]

  networks_advanced {
    name = var.network_name
  }
}
