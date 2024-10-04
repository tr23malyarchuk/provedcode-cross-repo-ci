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

data "docker_network" "existing_network" {
  name = "app_network"
}

resource "docker_image" "frontend_image" {
  name = "tr23malyarchuk/frontginx:v1"
}

resource "docker_container" "frontend" {
  name    = "frontginx"
  image   = docker_image.frontend_image.name
  restart = "unless-stopped"

  env = [
    "NODE_ENV=production",
    "REACT_APP_BASE_URL=/api"
  ]

  ports {
    internal = 80
    external = 80
  }

  networks_advanced {
    name = data.docker_network.existing_network.id
  }
}
