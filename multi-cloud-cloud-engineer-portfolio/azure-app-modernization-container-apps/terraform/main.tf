resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-${local.name_prefix}"
  location = local.location
  tags     = local.tags
}

resource "azurerm_log_analytics_workspace" "law" {
  name                = "law-${local.name_prefix}-${random_string.suffix.result}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags                = local.tags
}

resource "azurerm_container_app_environment" "cae" {
  name                       = "cae-${local.name_prefix}"
  location                   = azurerm_resource_group.rg.location
  resource_group_name        = azurerm_resource_group.rg.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.law.id
  tags                       = local.tags
}

resource "azurerm_container_registry" "acr" {
  name                = replace("acr${local.name_prefix}${random_string.suffix.result}", "-", "")
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic"
  admin_enabled       = true
  tags                = local.tags
}

resource "azurerm_postgresql_flexible_server" "pg" {
  name                   = "pg-${local.name_prefix}-${random_string.suffix.result}"
  resource_group_name    = azurerm_resource_group.rg.name
  location               = azurerm_resource_group.rg.location
  version                = "15"
  administrator_login    = var.db_username
  administrator_password = var.db_password
  sku_name               = var.postgres_sku
  storage_mb             = 32768
  backup_retention_days  = 7
  geo_redundant_backup_enabled = false
  tags                   = local.tags
}

resource "azurerm_postgresql_flexible_server_database" "db" {
  name      = "appdb"
  server_id = azurerm_postgresql_flexible_server.pg.id
  charset   = "UTF8"
  collation = "en_US.utf8"
}

resource "azurerm_postgresql_flexible_server_firewall_rule" "allow_azure" {
  name             = "AllowAzureServices"
  server_id        = azurerm_postgresql_flexible_server.pg.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}

resource "azurerm_postgresql_flexible_server_firewall_rule" "optional_public" {
  count            = var.public_db_access ? 1 : 0
  name             = "AllowPublicAll"
  server_id        = azurerm_postgresql_flexible_server.pg.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "255.255.255.255"
}

resource "azurerm_container_app" "app" {
  name                         = "app-${local.name_prefix}"
  container_app_environment_id  = azurerm_container_app_environment.cae.id
  resource_group_name          = azurerm_resource_group.rg.name
  revision_mode                = "Single"
  tags                         = local.tags

  template {
    container {
      name   = "app"
      image  = "${azurerm_container_registry.acr.login_server}/app:latest"
      cpu    = 0.5
      memory = "1Gi"

      env {
        name  = "PORT"
        value = tostring(var.container_port)
      }
      env {
        name  = "DB_HOST"
        value = azurerm_postgresql_flexible_server.pg.fqdn
      }
      env {
        name  = "DB_NAME"
        value = azurerm_postgresql_flexible_server_database.db.name
      }
      env {
        name  = "DB_USER"
        value = "${var.db_username}@${azurerm_postgresql_flexible_server.pg.name}"
      }
      env {
        name        = "DB_PASS"
        secret_name = "dbpass"
      }
    }
  }

  secret {
    name  = "dbpass"
    value = var.db_password
  }

  ingress {
    external_enabled = true
    target_port      = var.container_port
    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }

  registry {
    server               = azurerm_container_registry.acr.login_server
    username             = azurerm_container_registry.acr.admin_username
    password_secret_name = "acrpass"
  }

  secret {
    name  = "acrpass"
    value = azurerm_container_registry.acr.admin_password
  }
}

# Basic alert: if container app logs show repeated readiness failures
resource "azurerm_monitor_scheduled_query_rules_alert_v2" "readiness_alert" {
  name                = "alert-${local.name_prefix}-readiness"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  evaluation_frequency = "PT5M"
  window_duration      = "PT5M"
  severity             = 3
  enabled              = true

  scopes = [azurerm_log_analytics_workspace.law.id]

  criteria {
    query = <<-KQL
      ContainerAppConsoleLogs_CL
      | where TimeGenerated > ago(5m)
      | where Log_s contains "ready" or Log_s contains "DB"
    KQL
    time_aggregation_method = "Count"
    threshold               = 50
    operator                = "GreaterThan"
  }

  description = "High volume of readiness/DB log messages may indicate DB connectivity issues."
}
