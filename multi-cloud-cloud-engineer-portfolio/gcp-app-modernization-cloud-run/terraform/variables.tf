variable "project_id" {
  type        = string
  description = "GCP project id"
  default     = "your-gcp-project-id"
}

variable "project_name" {
  type        = string
  default     = "multicloud-demo"
  description = "Naming prefix"
}

variable "environment" {
  type        = string
  default     = "dev"
}

variable "region" {
  type        = string
  default     = "us-east1"
}

variable "container_port" {
  type        = number
  default     = 8080
}

variable "db_username" {
  type        = string
  default     = "appadmin"
}

variable "db_password" {
  type        = string
  default     = "ChangeMe-StrongPassword!234"
  sensitive   = true
}
