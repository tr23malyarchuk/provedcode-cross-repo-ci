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

provider "kubernetes" {
  host                   = "https://34.29.194.163"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(data.google_container_cluster.primary.master_auth[0].cluster_ca_certificate)
}

data "google_client_config" "default" {}

data "google_container_cluster" "primary" {
  name     = "primary-cluster"
  location = "us-central1"
}


resource "kubernetes_deployment" "frontend_deployment" {
  metadata {
    name = "frontend-app"
    labels = {
      app = "frontend"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "frontend"
      }
    }

    template {
      metadata {
        labels = {
          app = "frontend"
        }
      }

      spec {
        container {
          name  = "frontend"
          image = "tr23malyarchuk/frontginx:v1"

          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_deployment" "backend_deployment" {
  metadata {
    name = "backend-app"
    labels = {
      app = "backend"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "backend"
      }
    }

    template {
      metadata {
        labels = {
          app = "backend"
        }
      }

      spec {
        container {
          name  = "backend"
          image = "tr23malyarchuk/mavenback:v2"

          port {
            container_port = 8080
          }
        }
      }
    }
  }
}
