resource "docker_volume" "db_data" {
  name = "db_data"
}

resource "docker_image" "db_image" {
  name = "postgres:13"
}

resource "docker_container" "db" {
  name    = "db"
  image   = docker_image.db_image.name
  restart = "always"

  env = [
    "POSTGRES_DB=provedcode",
    "POSTGRES_USER=app_user",
    "POSTGRES_PASSWORD=app_pass"
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
