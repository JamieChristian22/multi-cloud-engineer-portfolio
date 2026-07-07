output "notification_channel_name" { value = google_monitoring_notification_channel.email.name }
output "alert_policy_name" { value = google_monitoring_alert_policy.uptime_failure.name }
output "dashboard_id" { value = google_monitoring_dashboard.platform.id }
output "log_bucket_id" { value = google_logging_project_bucket_config.platform.bucket_id }
