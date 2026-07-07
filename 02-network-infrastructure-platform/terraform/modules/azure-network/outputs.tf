output "resource_group_name" { value = azurerm_resource_group.network.name }
output "vnet_id" { value = azurerm_virtual_network.main.id }
output "subnet_ids" { value = { for k, v in azurerm_subnet.main : k => v.id } }
output "network_security_group_id" { value = azurerm_network_security_group.main.id }
