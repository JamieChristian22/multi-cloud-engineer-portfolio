variable "gcp_project_id" {
  description = "GCP project ID."
  type        = string
}

variable "gcp_region" {
  description = "GCP region used for the enterprise web platform."
  type        = string
  default     = "us-east1"
}

variable "project_name" {
  description = "Project name used for naming resources."
  type        = string
  default     = "enterprise-web-platform"
}

variable "environment" {
  description = "Environment name."
  type        = string
  default     = "dev"
}

variable "owner" {
  description = "Owner label for portfolio and cost tracking."
  type        = string
  default     = "jamiechristian22"
}
