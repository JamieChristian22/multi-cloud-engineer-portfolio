output "resource_group_name" {
  description = "Resource group created by Terraform."
  value       = azurerm_resource_group.enterprise.name
}

output "azure_region" {
  description = "Azure region used for deployment."
  value       = azurerm_resource_group.enterprise.location
}

output "vnet_name" {
  description = "Virtual Network name."
  value       = azurerm_virtual_network.enterprise.name
}

output "vnet_address_space" {
  description = "Virtual Network address space."
  value       = azurerm_virtual_network.enterprise.address_space
}

output "subnet_name" {
  description = "Application subnet name."
  value       = azurerm_subnet.app.name
}

output "subnet_address_prefix" {
  description = "Application subnet address prefix."
  value       = azurerm_subnet.app.address_prefixes
}

output "network_security_group_name" {
  description = "Network Security Group name."
  value       = azurerm_network_security_group.enterprise.name
}

output "allowed_inbound_ports" {
  description = "Inbound ports intentionally allowed for web traffic."
  value       = ["80", "443"]
}

output "storage_account_name" {
  description = "Azure Storage Account name."
  value       = azurerm_storage_account.enterprise.name
}

output "blob_container_name" {
  description = "Private blob container name."
  value       = azurerm_storage_container.project_files.name
}

output "key_vault_name" {
  description = "Azure Key Vault name."
  value       = azurerm_key_vault.enterprise.name
}

output "app_service_plan_name" {
  description = "Azure App Service Plan name."
  value       = azurerm_service_plan.enterprise.name
}

output "web_app_name" {
  description = "Azure Linux Web App name."
  value       = azurerm_linux_web_app.enterprise.name
}

output "web_app_default_hostname" {
  description = "Default Azure hostname for the web app."
  value       = azurerm_linux_web_app.enterprise.default_hostname
}

output "web_app_url" {
  description = "Public HTTPS URL for the deployed Azure Web App."
  value       = "https://${azurerm_linux_web_app.enterprise.default_hostname}"
}

output "monitor_alert_name" {
  description = "Azure Monitor alert rule name."
  value       = azurerm_monitor_metric_alert.web_app_requests.name
}
