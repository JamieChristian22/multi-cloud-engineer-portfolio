module "secure_data_lake" {
  source = "../modules/aws-storage"

  bucket_name = "${var.project_name}-${var.environment}-${var.bucket_suffix}"
  environment = var.environment
  project     = var.project_name
}
