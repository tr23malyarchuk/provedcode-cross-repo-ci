variable "credentials_path" {
  description = "Path to the service account credentials file"
  type        = string
}

variable "project_id" {
  description = "The ID of the Google Cloud project"
  type        = string
}

variable "region" {
  description = "The region where the resources will be created"
  type        = string
}

variable "network_name" {
  description = "Name of the network"
  type        = string
}

variable "subnetwork_name" {
  description = "Name of the subnetwork"
  type        = string
}

variable "ip_cidr_range" {
  description = "IP CIDR range for the subnetwork"
  type        = string
}

variable "cluster_name" {
  description = "Name of the Kubernetes cluster"
  type        = string
}

variable "node_pool_name" {
  description = "Name of the node pool"
  type        = string
}

variable "namespace_name" {
  description = "Kubernetes namespace"
  type        = string
}

variable "deployment_name" {
  description = "Kubernetes deployment name"
  type        = string
}

variable "replicas" {
  description = "Number of replicas"
  type        = number
}

variable "container_name" {
  description = "Container name"
  type        = string
}

variable "container_image" {
  description = "Container image"
  type        = string
}

variable "container_port" {
  description = "Container port"
  type        = number
}

variable "service_name" {
  description = "Service name"
  type        = string
}

variable "service_port" {
  description = "Service port"
  type        = number
}

variable "node_count" {
  description = "Amount of nodes"
  type        = number
}
