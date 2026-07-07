locals {
  common_labels = {
    project     = replace(var.project_name, "-", "_")
    environment = var.environment
    owner       = lower(var.owner)
    managed_by  = "terraform"
    portfolio   = "multi_cloud_engineer_portfolio"
  }
}

module "gcp_web_platform" {
  source = "../modules/gcp-web"

  project_name = var.project_name
  environment  = var.environment
  region       = var.gcp_region
  labels       = local.common_labels
}
