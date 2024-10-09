variable "project_id" {
  description = "The project ID to deploy the VM"
  type        = string
  default     = "zeta-sky-437510-j6"
}

variable "credentials" {
  description = "The location of GCP creds JSON file"
  type        = string
  default     = "creds/zeta-sky-437510-j6-286cd01fd991.json"
}

variable "region" {
  description = "The region to deploy the VM"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "The zone to deploy the VM"
  type        = string
  default     = "us-central1-a"
}

variable "vm_name" {
  description = "The name of the VM"
  type        = string
  default     = "my-vm-instance"
}

variable "machine_type" {
  description = "The machine type"
  type        = string
  default     = "e2-small"
}

variable "disk_size" {
  description = "The size of the boot disk in GB"
  type        = number
  default     = 10
}
