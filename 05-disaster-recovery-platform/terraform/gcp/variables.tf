variable "project_id" { description = "GCP project ID." type = string }
variable "project_name" { type = string default = "multi-cloud-dr-platform" }
variable "environment" { type = string default = "dev" }
variable "primary_region" { type = string default = "us-east1" }
variable "dr_region" { type = string default = "us-west1" }
variable "multi_region" { type = string default = "US" }
variable "unique_suffix" { type = string default = "jc212" }
variable "archive_after_days" { type = number default = 30 }
variable "delete_after_days" { type = number default = 365 }
variable "force_destroy" { type = bool default = false }
variable "notification_email" { type = string default = "" }
