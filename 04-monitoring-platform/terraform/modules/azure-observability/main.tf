resource "azurerm_resource_group" "monitoring" {
  name     = "rg-${var.project_name}-${var.environment}-monitoring"
  location = var.location

  tags = local.tags
}

resource "azurerm_log_analytics_workspace" "platform" {
  name                = "law-${var.project_name}-${var.environment}"
  location            = azurerm_resource_group.monitoring.location
  resource_group_name = azurerm_resource_group.monitoring.name
  sku                 = "PerGB2018"
  retention_in_days   = var.log_retention_days

  tags = local.tags
}

resource "azurerm_application_insights" "platform" {
  name                = "appi-${var.project_name}-${var.environment}"
  location            = azurerm_resource_group.monitoring.location
  resource_group_name = azurerm_resource_group.monitoring.name
  workspace_id        = azurerm_log_analytics_workspace.platform.id
  application_type    = "web"

  tags = local.tags
}

resource "azurerm_monitor_action_group" "alerts" {
  name                = "ag-${var.project_name}-${var.environment}-alerts"
  resource_group_name = azurerm_resource_group.monitoring.name
  short_name          = "platmon"

  email_receiver {
    name          = "portfolio-admin"
    email_address = var.alert_email
  }

  tags = local.tags
}

resource "azurerm_monitor_metric_alert" "workspace_availability" {
  name                = "alert-${var.project_name}-${var.environment}-availability"
  resource_group_name = azurerm_resource_group.monitoring.name
  scopes              = [azurerm_application_insights.platform.id]
  description         = "Portfolio alert for application availability monitoring."
  severity            = 2
  frequency           = "PT5M"
  window_size         = "PT15M"

  criteria {
    metric_namespace = "microsoft.insights/components"
    metric_name      = "availabilityResults/availabilityPercentage"
    aggregation      = "Average"
    operator         = "LessThan"
    threshold        = 95
  }

  action {
    action_group_id = azurerm_monitor_action_group.alerts.id
  }

  tags = local.tags
}

locals {
  tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Portfolio   = "multi-cloud-engineer-portfolio"
  }
}
