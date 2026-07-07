module "gcp_network" {
  source = "../modules/gcp-network"

  project_name       = var.project_name
  environment        = var.environment
  subnets            = var.subnets
  allowed_admin_cidr = var.allowed_admin_cidr
}
