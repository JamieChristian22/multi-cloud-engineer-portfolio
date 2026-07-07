resource "google_monitoring_notification_channel" "email" {
  display_name = "${var.project_name}-${var.environment}-email-alerts"
  type         = "email"

  labels = {
    email_address = var.alert_email
  }
}

resource "google_monitoring_uptime_check_config" "web" {
  display_name = "${var.project_name}-${var.environment}-uptime-check"
  timeout      = "10s"
  period       = "300s"

  http_check {
    path         = "/"
    port         = 443
    use_ssl      = true
    validate_ssl = true
  }

  monitored_resource {
    type = "uptime_url"
    labels = {
      project_id = var.gcp_project_id
      host       = var.uptime_check_host
    }
  }
}

resource "google_monitoring_alert_policy" "uptime_failure" {
  display_name = "${var.project_name}-${var.environment}-uptime-failure"
  combiner     = "OR"
  enabled      = true

  conditions {
    display_name = "Uptime check failed"

    condition_threshold {
      filter          = "metric.type=\"monitoring.googleapis.com/uptime_check/check_passed\" AND resource.type=\"uptime_url\""
      duration        = "300s"
      comparison      = "COMPARISON_LT"
      threshold_value = 1

      aggregations {
        alignment_period   = "300s"
        per_series_aligner = "ALIGN_NEXT_OLDER"
      }
    }
  }

  notification_channels = [google_monitoring_notification_channel.email.name]

  documentation {
    content   = "Portfolio alert for uptime failures on the monitored web endpoint."
    mime_type = "text/markdown"
  }
}

resource "google_logging_project_bucket_config" "platform" {
  project        = var.gcp_project_id
  location       = "global"
  retention_days = var.log_retention_days
  bucket_id      = "${var.project_name}-${var.environment}-logs"
  description    = "Centralized portfolio log bucket for monitoring platform."
}

resource "google_monitoring_dashboard" "platform" {
  dashboard_json = jsonencode({
    displayName = "${var.project_name}-${var.environment}-dashboard"
    mosaicLayout = {
      columns = 12
      tiles = [
        {
          width  = 6
          height = 4
          widget = {
            title = "Uptime Check"
            scorecard = {
              timeSeriesQuery = {
                timeSeriesFilter = {
                  filter = "metric.type=\"monitoring.googleapis.com/uptime_check/check_passed\""
                  aggregation = {
                    alignmentPeriod  = "300s"
                    perSeriesAligner = "ALIGN_MEAN"
                  }
                }
              }
            }
          }
        }
      ]
    }
  })
}
