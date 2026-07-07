output "cloudwatch_log_group_name" {
  value = module.aws_observability.log_group_name
}

output "sns_topic_arn" {
  value = module.aws_observability.sns_topic_arn
}

output "dashboard_name" {
  value = module.aws_observability.dashboard_name
}
