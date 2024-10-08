terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.0"
    }
  }
}

provider "google" {
  credentials = file("zeta-sky-437510-j6-286cd01fd991.json")
  project     = var.project_id
  region      = var.region
}

provider "docker" {
  host = "tcp://127.0.0.1:2375/"
}


variable "project_id" {
  description = "The project ID to deploy the VM"
  type        = string
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

resource "google_compute_instance" "default" {
  name         = var.vm_name
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/debian-11-bullseye-v20240910"
      size  = var.disk_size
    }
  }

  network_interface {
    network = "default"
    access_config {
      // Ephemeral IP
    }
  }

  metadata_startup_script = <<-EOF
    #! /bin/bash
    echo "Hello, world!" > /var/log/startup-script.log
  EOF
}

output "ip_address" {
  value = google_compute_instance.default.network_interface[0].access_config[0].nat_ip
}
