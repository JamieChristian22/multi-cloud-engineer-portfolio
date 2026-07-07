locals {
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    Owner       = var.owner
    ManagedBy   = "Terraform"
    Portfolio   = "multi-cloud-engineer-portfolio"
  }
}

module "azure_web_platform" {
  source = "../modules/azure-web"

  project_name = var.project_name
  environment  = var.environment
  location     = var.location
  tags         = local.common_tags
}
