output "resource_group" { value = azurerm_resource_group.rg.name }
output "vnet_name" { value = azurerm_virtual_network.vnet.name }
output "vm_public_ip" { value = azurerm_public_ip.pip.ip_address }
output "storage_account" { value = azurerm_storage_account.sa.name }
