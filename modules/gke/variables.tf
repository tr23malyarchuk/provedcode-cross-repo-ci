variable "credentials_path" {
  description = "Path to the service account credentials file"
  type        = string
}

variable "project_id" {
  description = "Google Cloud project ID"
  type        = string
}

variable "region" {
  description = "Google Cloud region"
  type        = string
  default     = "us-central1" # Default region
}

variable "network_name" {
  description = "Name of the VPC network"
  type        = string
  default     = "my-vpc-network"
}

variable "subnetwork_name" {
  description = "Name of the subnetwork"
  type        = string
  default     = "my-subnetwork"
}

variable "ip_cidr_range" {
  description = "CIDR range for the subnetwork"
  type        = string
  default     = "10.128.0.0/20"
}

variable "cluster_name" {
  description = "Name of the Kubernetes cluster"
  type        = string
  default     = "my-eks-cluster"
}

variable "node_count" {
  description = "Number of nodes in the cluster"
  type        = number
  default     = 3
}

variable "machine_type" {
  description = "Machine type for the nodes"
  type        = string
  default     = "n1-standard-1"
}

variable "namespace_name" {
  description = "Name of the Kubernetes namespace"
  type        = string
  default     = "my-app-namespace"
}

variable "deployment_name" {
  description = "Name of the Kubernetes deployment"
  type        = string
  default     = "my-app-deployment"
}

variable "replicas" {
  description = "Number of replicas for the deployment"
  type        = number
  default     = 2
}

variable "container_name" {
  description = "Name of the container"
  type        = string
  default     = "my-app-container"
}

variable "container_image" {
  description = "Docker image for the container"
  type        = string
  default     = "gcr.io/my-project/my-app:latest"
}

variable "container_port" {
  description = "Port for the container"
  type        = number
  default     = 80
}

variable "service_name" {
  description = "Name of the Kubernetes service"
  type        = string
  default     = "my-app-service"
}

variable "service_port" {
  description = "Port for the Kubernetes service"
  type        = number
  default     = 80
}

variable "node_pool_name" {
  description = "Name of the Kubernetes node pool"
  type        = string
  default     = "my-node-pool"
}
