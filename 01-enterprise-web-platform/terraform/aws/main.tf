locals {
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    Owner       = var.owner
    ManagedBy   = "Terraform"
    Portfolio   = "multi-cloud-engineer-portfolio"
  }
}

module "aws_web_platform" {
  source = "../modules/aws-web"

  project_name = var.project_name
  environment  = var.environment
}
