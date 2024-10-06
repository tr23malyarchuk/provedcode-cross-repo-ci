# Path to the service account key file
variable "credentials_path" {
  description = "Path to the service account credentials file"
  type        = string
}

# Google Cloud project ID
variable "project_id" {
  description = "Google Cloud project ID"
  type        = string
}

# Google Cloud region
variable "region" {
  description = "Google Cloud region"
  type        = string
  default     = "us-central1" # Default region
}

# VPC network name
variable "network_name" {
  description = "Name of the VPC network"
  type        = string
  default     = "my-vpc-network"
}

# Subnetwork name
variable "subnetwork_name" {
  description = "Name of the subnetwork"
  type        = string
  default     = "my-subnetwork"
}

# Subnetwork CIDR range
variable "ip_cidr_range" {
  description = "CIDR range for the subnetwork"
  type        = string
  default     = "10.128.0.0/20"
}

# Kubernetes cluster name
variable "cluster_name" {
  description = "Name of the Kubernetes cluster"
  type        = string
  default     = "my-eks-cluster"
}

# Kubernetes node count
variable "node_count" {
  description = "Number of nodes in the cluster"
  type        = number
  default     = 3
}

# Node machine type
variable "machine_type" {
  description = "Machine type for the nodes"
  type        = string
  default     = "n1-standard-1"
}

# Kubernetes namespace name
variable "namespace_name" {
  description = "Name of the Kubernetes namespace"
  type        = string
  default     = "my-app-namespace"
}

# Kubernetes deployment name
variable "deployment_name" {
  description = "Name of the Kubernetes deployment"
  type        = string
  default     = "my-app-deployment"
}

# Number of replicas for the deployment
variable "replicas" {
  description = "Number of replicas for the deployment"
  type        = number
  default     = 2
}

# Container name
variable "container_name" {
  description = "Name of the container"
  type        = string
  default     = "my-app-container"
}

# Container image
variable "container_image" {
  description = "Docker image for the container"
  type        = string
  default     = "gcr.io/my-project/my-app:latest"
}

# Container port
variable "container_port" {
  description = "Port for the container"
  type        = number
  default     = 80
}

# Kubernetes service name
variable "service_name" {
  description = "Name of the Kubernetes service"
  type        = string
  default     = "my-app-service"
}

# Kubernetes service port
variable "service_port" {
  description = "Port for the Kubernetes service"
  type        = number
  default     = 80
}

# Node pool name
variable "node_pool_name" {
  description = "Name of the Kubernetes node pool"
  type        = string
  default     = "my-node-pool"
}
