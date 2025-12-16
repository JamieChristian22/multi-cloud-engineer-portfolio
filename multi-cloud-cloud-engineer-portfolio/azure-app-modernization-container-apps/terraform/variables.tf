variable "project_name" {
  type        = string
  default     = "multicloud-demo"
  description = "Project name used for naming"
}

variable "environment" {
  type        = string
  default     = "dev"
  description = "Environment name"
}

variable "location" {
  type        = string
  default     = "eastus"
  description = "Azure region"
}

variable "container_port" {
  type        = number
  default     = 8080
  description = "Container listening port"
}

variable "db_username" {
  type        = string
  default     = "appadmin"
  description = "Postgres admin username"
}

variable "db_password" {
  type        = string
  default     = "ChangeMe-StrongPassword!234"
  sensitive   = true
  description = "Postgres admin password (use Key Vault/Secrets in production)"
}

variable "postgres_sku" {
  type        = string
  default     = "B_Standard_B1ms"
  description = "PostgreSQL Flexible Server SKU (dev-friendly default)"
}

variable "public_db_access" {
  type        = bool
  default     = true
  description = "If true, allows public DB access (dev). For prod, set false and use private networking."
}
