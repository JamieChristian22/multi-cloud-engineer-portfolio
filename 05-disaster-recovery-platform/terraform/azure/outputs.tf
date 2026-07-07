output "primary_resource_group" { value = azurerm_resource_group.primary.name }
output "dr_resource_group" { value = azurerm_resource_group.dr.name }
output "recovery_services_vault" { value = azurerm_recovery_services_vault.primary.name }
output "dr_artifacts_storage_account" { value = azurerm_storage_account.dr_artifacts.name }
output "log_analytics_workspace" { value = azurerm_log_analytics_workspace.dr.name }
