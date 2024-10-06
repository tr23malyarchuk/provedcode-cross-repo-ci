variable "frontend_image" {
  description = "Docker image for frontend container"
  type        = string
  default     = "tr23malyarchuk/frontginx:v1"
}

variable "backend_image" {
  description = "Docker image for backend container"
  type        = string
  default     = "tr23malyarchuk/mavenback:v2"
}
