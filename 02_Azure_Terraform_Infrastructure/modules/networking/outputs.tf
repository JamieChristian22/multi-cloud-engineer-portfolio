output "vnet_name" { value = azurerm_virtual_network.this.name }
output "subnet_name" { value = azurerm_subnet.app.name }
output "subnet_id" { value = azurerm_subnet.app.id }
output "network_security_group_name" { value = azurerm_network_security_group.this.name }
