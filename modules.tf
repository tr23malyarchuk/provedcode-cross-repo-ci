module "backend" {
  source       = "./modules/backend"
  network_name = module.network.network_name
  db_user      = var.db_user
  db_password  = var.db_password
}

module "db" {
  source       = "./modules/db"
  network_name = module.network.network_name
  db_user      = var.db_user
  db_password  = var.db_password
}

module "frontend" {
  source       = "./modules/frontend"
  network_name = module.network.network_name
}

module "gke" {
  source           = "./modules/gke"
  project_id       = var.project_id
  region           = var.region
  credentials_path = var.credentials_path
}

module "gke_containers" {
  source            = "./modules/gke-containers"
  credentials_path  = var.credentials_path
  project_id        = var.project_id
  region            = var.region
  network_name      = "my-network"
  subnetwork_name   = "my-subnetwork"
  ip_cidr_range     = "10.0.0.0/16"
  cluster_name      = "my-cluster"
  node_count        = 3
  node_pool_name    = "my-node-pool"
  namespace_name    = "my-namespace"
  deployment_name   = "my-deployment"
  replicas          = 1
  container_name    = "my-container"
  container_image   = "my-container-image"
  container_port    = 80
  service_name      = "my-service"
  service_port      = 80
}

module "network" {
  source = "./modules/network"
}
