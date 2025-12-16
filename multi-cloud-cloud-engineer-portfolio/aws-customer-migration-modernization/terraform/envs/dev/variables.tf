variable "aws_region" {
  type        = string
  description = "AWS region to deploy into"
  default     = "us-east-1"
}

variable "project_name" {
  type        = string
  description = "Project name used for naming"
  default     = "mission-cloud-demo"
}

variable "environment" {
  type        = string
  description = "Environment name"
  default     = "dev"
}

variable "app_container_port" {
  type        = number
  description = "Port the container listens on"
  default     = 8080
}

variable "db_username" {
  type        = string
  description = "RDS master username"
  default     = "appadmin"
}

variable "db_password" {
  type        = string
  description = "RDS master password (for demo; use Secrets Manager in production)"
  sensitive   = true
  default     = "ChangeMe-StrongPassword!234"
}
