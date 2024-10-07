variable "db_user" {
  description = "Database username."
  default     = "app_user"
}

variable "db_password" {
  description = "Database password."
  default     = "app_pass"
}

variable "region" {
  description = "The region where the resources will be created"
  type        = string
  default     = "us-central1"
}

variable "credentials_path" {
  description = "Path to the service account credentials file"
  type        = string
  default     = "zeta-sky-437510-j6-286cd01fd991.json"
}

variable "project_id" {
  description = "The ID of the Google Cloud project"
  type        = string
  default     = "zeta-sky-437510-j6"
}

variable "network_name" {
  description = "The name of a network that will be used"
  type        = string
  default     = "my-network"
}

variable "subnetwork_name" {
  description = "The name of a subnetwork that will be used"
  type        = string
  default     = "subnetwork_name"
}

variable "ip_cidr_range" {
  description = "The range of internal addresses that are owned by this subnetwork"
  type        = string
  default     = "10.0.0.0/16"
}

variable "cluster_name" {
  description = "The name of the Kubernetes cluster."
  type        = string
  default     = "my-cluster"
}

variable "node_count" {
  description = "The number of nodes in the Kubernetes cluster."
  type        = number
  default     = 3
}

variable "node_pool_name" {
  description = "The name of the node pool in the Kubernetes cluster."
  type        = string
  default     = "my-node-pool"
}

variable "namespace_name" {
  description = "The name of the Kubernetes namespace."
  type        = string
  default     = "my-namespace"
}

variable "deployment_name" {
  description = "The name of the Kubernetes deployment."
  type        = string
  default     = "my-deployment"
}

variable "replicas" {
  description = "The number of replicas for the deployment."
  type        = number
  default     = 1
}

variable "container_name" {
  description = "The name of the container."
  type        = string
  default     = "my-container"
}

variable "container_image" {
  description = "The image of the container."
  type        = string
  default     = "my-container-image"
}

variable "container_port" {
  description = "The port on which the container will listen."
  type        = number
  default     = 80
}

variable "service_name" {
  description = "The name of the Kubernetes service."
  type        = string
  default     = "my-service"
}

variable "service_port" {
  description = "The port for the Kubernetes service."
  type        = number
  default     = 80
}
