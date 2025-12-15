provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.name}-rg"
  location = var.location
}

resource "azurerm_container_registry" "acr" {
  name                = replace("${var.name}acr", "-", "")
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  sku                 = "Basic"
  admin_enabled       = true
}

resource "azurerm_log_analytics_workspace" "law" {
  name                = "${var.name}-law"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_container_app_environment" "env" {
  name                       = "${var.name}-cae"
  location                   = var.location
  resource_group_name        = azurerm_resource_group.rg.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.law.id
}

# App image defaults to :latest; CI can push immutable tags and you can update revisions
locals {
  image = "${azurerm_container_registry.acr.login_server}/app:latest"
}

resource "azurerm_container_app" "app" {
  name                         = "${var.name}-app"
  container_app_environment_id  = azurerm_container_app_environment.env.id
  resource_group_name          = azurerm_resource_group.rg.name
  revision_mode                = "Single"

  ingress {
    external_enabled = true
    target_port      = 3000
    transport        = "auto"
    traffic_weight { percentage = 100, latest_revision = true }
  }

  template {
    container {
      name   = "app"
      image  = local.image
      cpu    = 0.25
      memory = "0.5Gi"
      env { name = "CLOUD_PROVIDER" value = "azure" }
    }
  }

  registry {
    server               = azurerm_container_registry.acr.login_server
    username             = azurerm_container_registry.acr.admin_username
    password_secret_name = "acr-pwd"
  }

  secret {
    name  = "acr-pwd"
    value = azurerm_container_registry.acr.admin_password
  }
}

output "acr_login_server" { value = azurerm_container_registry.acr.login_server }
output "acr_admin_username" { value = azurerm_container_registry.acr.admin_username }
output "container_app_url" { value = azurerm_container_app.app.latest_revision_fqdn }
