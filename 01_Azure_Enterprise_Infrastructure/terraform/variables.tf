variable "resource_group_name" {
  description = "Azure resource group for the enterprise cloud platform."
  type        = string
  default     = "rg-enterprise-infra"
}

variable "location" {
  description = "Azure region for all deployed resources."
  type        = string
  default     = "East US"
}

variable "virtual_network_name" {
  description = "Enterprise virtual network name."
  type        = string
  default     = "vnet-enterprise"
}

variable "app_subnet_name" {
  description = "Application subnet name."
  type        = string
  default     = "app-subnet"
}

variable "network_security_group_name" {
  description = "Network security group name."
  type        = string
  default     = "nsg-enterprise"
}

variable "demo_db_password" {
  description = "Demo secret value stored in Azure Key Vault. Change before real production use."
  type        = string
  sensitive   = true
  default     = "PortfolioDemoPassword!2026"
}
