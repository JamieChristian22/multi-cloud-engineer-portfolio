variable "name_prefix" { type = string, default = "mc-foundation-dev" }
variable "allowed_ssh_cidr" { type = string, default = "0.0.0.0/0" } # tighten for real deployments

variable "aws_region" { type = string, default = "us-east-1" }
variable "azure_location" { type = string, default = "eastus" }

variable "gcp_project_id" { type = string }
variable "gcp_region" { type = string, default = "us-east1" }
