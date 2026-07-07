variable "aws_region" {
  description = "AWS region used for the enterprise web platform."
  type        = string
  default     = "us-east-1"
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
  description = "Owner tag for portfolio and cost tracking."
  type        = string
  default     = "JamieChristian22"
}
