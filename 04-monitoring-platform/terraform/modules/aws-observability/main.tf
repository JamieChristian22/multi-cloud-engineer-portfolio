resource "aws_cloudwatch_log_group" "platform" {
  name              = "/portfolio/${var.project_name}/${var.environment}/application"
  retention_in_days = var.log_retention_days
}

resource "aws_sns_topic" "alerts" {
  name = "${var.project_name}-${var.environment}-monitoring-alerts"
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = var.alert_email
}

resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "${var.project_name}-${var.environment}-high-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = var.cpu_alarm_threshold
  alarm_description   = "Portfolio alarm for high EC2 CPU utilization."
  alarm_actions       = [aws_sns_topic.alerts.arn]
  treat_missing_data  = "notBreaching"
}

resource "aws_cloudwatch_log_metric_filter" "error_count" {
  name           = "${var.project_name}-${var.environment}-error-count"
  log_group_name = aws_cloudwatch_log_group.platform.name
  pattern        = "ERROR"

  metric_transformation {
    name      = "ApplicationErrorCount"
    namespace = "Portfolio/${var.project_name}"
    value     = "1"
  }
}

resource "aws_cloudwatch_dashboard" "platform" {
  dashboard_name = "${var.project_name}-${var.environment}-dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6
        properties = {
          metrics = [["AWS/EC2", "CPUUtilization"]]
          period  = 300
          stat    = "Average"
          region  = data.aws_region.current.name
          title   = "EC2 CPU Utilization"
        }
      },
      {
        type   = "log"
        x      = 0
        y      = 6
        width  = 24
        height = 6
        properties = {
          query  = "SOURCE '${aws_cloudwatch_log_group.platform.name}' | fields @timestamp, @message | sort @timestamp desc | limit 20"
          region = data.aws_region.current.name
          title  = "Recent Application Logs"
        }
      }
    ]
  })
}

data "aws_region" "current" {}
