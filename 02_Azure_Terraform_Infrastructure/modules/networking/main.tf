resource "azurerm_virtual_network" "this" { name = var.vnet_name, location = var.location, resource_group_name = var.resource_group_name, address_space = [var.vnet_address_space], tags = var.tags }
resource "azurerm_subnet" "app" { name = var.subnet_name, resource_group_name = var.resource_group_name, virtual_network_name = azurerm_virtual_network.this.name, address_prefixes = [var.subnet_address_prefix] }
resource "azurerm_network_security_group" "this" {
  name = var.network_security_group_name, location = var.location, resource_group_name = var.resource_group_name, tags = var.tags
  security_rule { name="allow-http", priority=100, direction="Inbound", access="Allow", protocol="Tcp", source_port_range="*", destination_port_range="80", source_address_prefix="*", destination_address_prefix="*" }
  security_rule { name="allow-https", priority=110, direction="Inbound", access="Allow", protocol="Tcp", source_port_range="*", destination_port_range="443", source_address_prefix="*", destination_address_prefix="*" }
}
resource "azurerm_subnet_network_security_group_association" "app" { subnet_id = azurerm_subnet.app.id, network_security_group_id = azurerm_network_security_group.this.id }
