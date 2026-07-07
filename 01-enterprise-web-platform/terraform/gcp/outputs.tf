output "network_name" {
  description = "GCP VPC network name."
  value       = module.gcp_web_platform.network_name
}

output "subnet_name" {
  description = "GCP subnet name."
  value       = module.gcp_web_platform.subnet_name
}

output "firewall_rule_name" {
  description = "GCP firewall rule name for web traffic."
  value       = module.gcp_web_platform.firewall_rule_name
}
