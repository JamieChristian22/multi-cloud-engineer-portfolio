module "secure_storage_account" {
  source = "../modules/azure-storage"

  location     = var.location
  project_name = var.project_name
  environment  = var.environment
}
