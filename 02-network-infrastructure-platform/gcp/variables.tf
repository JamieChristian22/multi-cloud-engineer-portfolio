variable "project_id" {
  description = "GCP project ID."
  type        = string
}

variable "region" {
  description = "GCP region."
  type        = string
  default     = "us-east1"
}

variable "zone" {
  description = "GCP zone."
  type        = string
  default     = "us-east1-b"
}

variable "admin_cidr" {
  description = "Trusted public IP CIDR allowed for SSH. Use x.x.x.x/32 in production."
  type        = string
  default     = "0.0.0.0/0"
}
