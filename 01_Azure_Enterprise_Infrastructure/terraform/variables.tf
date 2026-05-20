variable "project_prefix" {
  description = "Short lowercase prefix used for Azure resource names."
  type        = string
  default     = "jcazent"
}

variable "location" {
  description = "Azure region for deployment."
  type        = string
  default     = "eastus"
}

variable "environment" {
  description = "Deployment environment name."
  type        = string
  default     = "dev"
}

variable "owner" {
  description = "Owner tag for governance and cost tracking."
  type        = string
  default     = "Jamie Christian"
}

variable "cost_center" {
  description = "Cost center tag for portfolio project tracking."
  type        = string
  default     = "portfolio-cloud-engineering"
}

variable "app_service_sku" {
  description = "App Service Plan SKU. F1 is free tier in supported regions/subscriptions; B1 is more reliable if F1 is unavailable."
  type        = string
  default     = "F1"
}
