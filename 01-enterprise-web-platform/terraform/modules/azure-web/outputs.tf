output "resource_group_name" {
  value = azurerm_resource_group.main.name
}

output "virtual_network_name" {
  value = azurerm_virtual_network.main.name
}

output "network_security_group_name" {
  value = azurerm_network_security_group.web.name
}
