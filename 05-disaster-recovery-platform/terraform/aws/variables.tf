variable "project_name" {
  description = "Project name used for resource naming."
  type        = string
  default     = "multi-cloud-dr-platform"
}

variable "environment" {
  description = "Environment name."
  type        = string
  default     = "dev"
}

variable "owner" {
  description = "Portfolio owner or team."
  type        = string
  default     = "Jamie Christian"
}

variable "primary_region" {
  description = "Primary AWS region."
  type        = string
  default     = "us-east-1"
}

variable "dr_region" {
  description = "Disaster recovery AWS region."
  type        = string
  default     = "us-west-2"
}

variable "unique_suffix" {
  description = "Unique suffix for globally unique bucket names."
  type        = string
  default     = "jc212"
}

variable "backup_schedule" {
  description = "AWS Backup cron schedule."
  type        = string
  default     = "cron(0 5 ? * * *)"
}

variable "cold_storage_after_days" {
  description = "Days before backup moves to cold storage."
  type        = number
  default     = 30
}

variable "delete_after_days" {
  description = "Days before backup is deleted."
  type        = number
  default     = 120
}
