module "azure_observability" {
  source = "../modules/azure-observability"

  project_name        = var.project_name
  environment         = var.environment
  location            = var.location
  alert_email         = var.alert_email
  log_retention_days  = var.log_retention_days
  cpu_alert_threshold = var.cpu_alert_threshold
}
