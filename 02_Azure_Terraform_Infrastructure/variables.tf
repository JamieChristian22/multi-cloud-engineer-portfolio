variable "resource_group_name" {
  description = "Actual Azure resource group used for the portfolio project."
  type        = string
  default     = "rg-enterprise-infra"
}

variable "location" {
  description = "Azure region used in the screenshots."
  type        = string
  default     = "East US"
}

variable "environment" {
  description = "Environment label for portfolio infrastructure."
  type        = string
  default     = "portfolio"
}

variable "vnet_name" {
  description = "Actual Azure Virtual Network name."
  type        = string
  default     = "vnet-enterprise"
}

variable "vnet_address_space" {
  description = "Actual VNet address space."
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_name" {
  description = "Actual subnet name."
  type        = string
  default     = "app-subnet"
}

variable "subnet_address_prefix" {
  description = "Actual subnet CIDR range."
  type        = string
  default     = "10.0.0.0/24"
}

variable "network_security_group_name" {
  description = "Actual Network Security Group name."
  type        = string
  default     = "nsg-enterprise"
}

variable "storage_account_name" {
  description = "Actual Azure Storage Account name from the project."
  type        = string
  default     = "stenterprisefiles"
}

variable "blob_container_name" {
  description = "Actual Blob Storage container name."
  type        = string
  default     = "project-files"
}

variable "key_vault_name" {
  description = "Actual Azure Key Vault name."
  type        = string
  default     = "kv-enterprise-demo"
}

variable "app_service_plan_name" {
  description = "Actual Azure App Service Plan name from the screenshots."
  type        = string
  default     = "ASP-rgenterpriseinfra-a004"
}

variable "web_app_name" {
  description = "Actual Azure Web App name."
  type        = string
  default     = "enterprise-app-demo"
}

variable "alert_rule_name" {
  description = "Azure Monitor metric alert rule name."
  type        = string
  default     = "webapp-requests-greater-than-5"
}

variable "tags" {
  description = "Filled-in project tags for portfolio resource organization."
  type        = map(string)

  default = {
    project       = "azure-enterprise-cloud-platform"
    environment   = "portfolio"
    owner         = "Jamie Christian"
    resource_group = "rg-enterprise-infra"
    cloud         = "Microsoft Azure"
    managed_by    = "Terraform"
  }
}
