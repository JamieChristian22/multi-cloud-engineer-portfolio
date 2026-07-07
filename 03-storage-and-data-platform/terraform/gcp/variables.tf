variable "gcp_project_id" {
  description = "GCP project ID."
  type        = string
}

variable "gcp_region" {
  description = "GCP region."
  type        = string
  default     = "us-east1"
}

variable "project_name" {
  description = "Project name."
  type        = string
  default     = "storage-data-platform"
}

variable "environment" {
  description = "Deployment environment."
  type        = string
  default     = "dev"
}

variable "bucket_suffix" {
  description = "Globally unique suffix for GCS bucket."
  type        = string
}
