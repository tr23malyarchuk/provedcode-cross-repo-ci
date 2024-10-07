data "docker_network" "existing_network" {
  name = "app_network"
}

resource "docker_network" "app_network" {
  count = length(data.docker_network.existing_network) == 0 ? 1 : 0

  name = "app_network"
}