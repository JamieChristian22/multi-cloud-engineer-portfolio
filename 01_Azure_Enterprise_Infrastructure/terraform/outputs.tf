output "resource_group_name" {
  value       = azurerm_resource_group.enterprise.name
  description = "Resource group created for the platform."
}

output "web_app_url" {
  value       = "https://${azurerm_linux_web_app.enterprise_app.default_hostname}"
  description = "Live Azure App Service URL."
}

output "storage_account_name" {
  value       = azurerm_storage_account.enterprise_files.name
  description = "Storage account used for project files and logs."
}

output "key_vault_name" {
  value       = azurerm_key_vault.enterprise.name
  description = "Azure Key Vault name."
}

output "virtual_network_name" {
  value       = azurerm_virtual_network.enterprise.name
  description = "Virtual network name."
}

output "network_security_group_name" {
  value       = azurerm_network_security_group.enterprise.name
  description = "Network security group name."
}
