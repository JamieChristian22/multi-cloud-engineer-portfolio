output "alb_dns_name" {
  value       = module.ecs.alb_dns_name
  description = "Public DNS name of the application load balancer"
}

output "ecs_cluster_name" {
  value       = module.ecs.cluster_name
  description = "ECS cluster name"
}

output "ecs_service_name" {
  value       = module.ecs.service_name
  description = "ECS service name"
}

output "rds_endpoint" {
  value       = module.rds.db_endpoint
  description = "RDS endpoint"
}

output "cloudwatch_log_group" {
  value       = module.observability.app_log_group_name
  description = "CloudWatch Log Group where app logs are written"
}
