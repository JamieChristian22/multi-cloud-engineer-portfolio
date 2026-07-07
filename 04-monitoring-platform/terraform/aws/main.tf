module "aws_observability" {
  source = "../modules/aws-observability"

  project_name        = var.project_name
  environment         = var.environment
  alert_email         = var.alert_email
  log_retention_days  = var.log_retention_days
  cpu_alarm_threshold = var.cpu_alarm_threshold
}
