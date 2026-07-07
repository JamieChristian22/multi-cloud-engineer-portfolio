module "secure_gcs_bucket" {
  source = "../modules/gcp-storage"

  bucket_name = "${var.project_name}-${var.environment}-${var.bucket_suffix}"
  location    = var.gcp_region
  project     = var.project_name
  environment = var.environment
}
