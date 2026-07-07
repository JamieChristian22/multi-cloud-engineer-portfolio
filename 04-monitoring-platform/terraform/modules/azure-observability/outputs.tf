output "resource_group_name" { value = azurerm_resource_group.monitoring.name }
output "log_analytics_workspace_id" { value = azurerm_log_analytics_workspace.platform.id }
output "application_insights_name" { value = azurerm_application_insights.platform.name }
output "action_group_name" { value = azurerm_monitor_action_group.alerts.name }
