variable "aws_region" {
  description = "AWS region for storage resources."
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name used for naming and tags."
  type        = string
  default     = "storage-data-platform"
}

variable "environment" {
  description = "Deployment environment."
  type        = string
  default     = "dev"
}

variable "bucket_suffix" {
  description = "Globally unique suffix for S3 bucket name."
  type        = string
}
