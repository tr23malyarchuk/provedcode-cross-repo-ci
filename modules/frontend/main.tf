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

  depends_on = [docker_container.backend]

  networks_advanced {
    name = var.network_name
  }
}
