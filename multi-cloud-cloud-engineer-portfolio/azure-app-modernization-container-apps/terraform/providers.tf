provider "azurerm" {
  features {}
}

locals {
  project_name = var.project_name
  location     = var.location
  name_prefix  = "${var.project_name}-${var.environment}"
  tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Owner       = "JamieChristian"
  }
}
