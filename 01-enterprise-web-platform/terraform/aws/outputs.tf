output "vpc_id" {
  description = "AWS VPC ID for the enterprise web platform."
  value       = module.aws_web_platform.vpc_id
}

output "public_subnet_ids" {
  description = "Public subnet IDs."
  value       = module.aws_web_platform.public_subnet_ids
}

output "security_group_id" {
  description = "Web security group ID."
  value       = module.aws_web_platform.security_group_id
}
