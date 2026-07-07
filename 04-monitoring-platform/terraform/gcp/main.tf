module "gcp_observability" {
  source = "../modules/gcp-observability"

  project_name       = var.project_name
  environment        = var.environment
  gcp_project_id     = var.gcp_project_id
  alert_email        = var.alert_email
  log_retention_days = var.log_retention_days
  uptime_check_host  = var.uptime_check_host
}
