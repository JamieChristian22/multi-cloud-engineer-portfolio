output "resource_group_name" {
  description = "Azure resource group name."
  value       = module.azure_web_platform.resource_group_name
}

output "virtual_network_name" {
  description = "Azure virtual network name."
  value       = module.azure_web_platform.virtual_network_name
}

output "network_security_group_name" {
  description = "Azure web network security group name."
  value       = module.azure_web_platform.network_security_group_name
}
