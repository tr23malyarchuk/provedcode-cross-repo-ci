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
  network_name      = var.network_name
  subnetwork_name   = var.subnetwork_name
  ip_cidr_range     = var.ip_cidr_range
  cluster_name      = var.cluster_name
  node_count        = var.node_count
  node_pool_name    = var.node_pool_name
  namespace_name    = var.namespace_name
  deployment_name   = var.deployment_name
  replicas          = var.replicas
  container_name    = var.container_name
  container_image   = var.container_image
  container_port    = var.container_port
  service_name      = var.service_name
  service_port      = var.service_port
}

module "network" {
  source = "./modules/network"
}
