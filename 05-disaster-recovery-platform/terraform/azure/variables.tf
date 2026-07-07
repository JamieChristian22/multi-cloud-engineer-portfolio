variable "project_name" { type = string default = "multi-cloud-dr-platform" }
variable "environment" { type = string default = "dev" }
variable "owner" { type = string default = "Jamie Christian" }
variable "primary_location" { type = string default = "East US" }
variable "dr_location" { type = string default = "West US 2" }
variable "unique_suffix" { type = string default = "jc212" }
variable "timezone" { type = string default = "Eastern Standard Time" }
variable "backup_time" { type = string default = "05:00" }
variable "daily_retention_days" { type = number default = 30 }
variable "weekly_retention_weeks" { type = number default = 8 }
variable "blob_delete_retention_days" { type = number default = 30 }
variable "log_retention_days" { type = number default = 30 }
