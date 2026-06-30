resource "aws_sns_topic" "alerts" {
  name = "enterprise-alerts"
}

resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "enterprise-web-high-cpu-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 70
  alarm_description   = "Alert when web server CPU is high."
  alarm_actions       = [aws_sns_topic.alerts.arn]
  dimensions = { InstanceId = var.instance_id }
}
