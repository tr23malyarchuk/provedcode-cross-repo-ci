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
