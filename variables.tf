variable "aws_region" {
  description = "The AWS region to deploy resources."
  default     = "us-west-2"
}

variable "instance_type" {
  description = "The type of EC2 instance."
  default     = "t2.micro"
}

variable "db_user" {
  description = "Database username."
  default     = "app_user"
}

variable "db_password" {
  description = "Database password."
  default     = "app_pass"
}
