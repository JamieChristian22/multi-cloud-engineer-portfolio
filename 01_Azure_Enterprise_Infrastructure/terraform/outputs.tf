output "resource_group_name" {
  description = "Name of the Azure Resource Group."
  value       = azurerm_resource_group.main.name
}

output "location" {
  description = "Azure region used for the deployment."
  value       = azurerm_resource_group.main.location
}

output "web_app_name" {
  description = "Name of the Azure Linux Web App."
  value       = azurerm_linux_web_app.main.name
}

output "web_app_url" {
  description = "Default HTTPS URL for the deployed Azure Web App."
  value       = "https://${azurerm_linux_web_app.main.default_hostname}"
}

output "storage_account_name" {
  description = "Name of the secure Azure Storage Account."
  value       = azurerm_storage_account.main.name
}

output "private_blob_container" {
  description = "Name of the private blob container."
  value       = azurerm_storage_container.project_files.name
}

output "key_vault_name" {
  description = "Name of the Azure Key Vault."
  value       = azurerm_key_vault.main.name
}

output "application_insights_name" {
  description = "Name of the Application Insights resource."
  value       = azurerm_application_insights.main.name
}

output "log_analytics_workspace_name" {
  description = "Name of the Log Analytics Workspace."
  value       = azurerm_log_analytics_workspace.main.name
}
