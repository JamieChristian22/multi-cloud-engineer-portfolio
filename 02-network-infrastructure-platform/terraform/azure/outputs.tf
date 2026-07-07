output "resource_group_name" { value = module.azure_network.resource_group_name }
output "vnet_id" { value = module.azure_network.vnet_id }
output "subnet_ids" { value = module.azure_network.subnet_ids }
output "network_security_group_id" { value = module.azure_network.network_security_group_id }
