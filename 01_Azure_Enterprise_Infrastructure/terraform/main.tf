terraform {
  required_version = ">= 1.6.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.110"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}

provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {}

resource "random_integer" "suffix" {
  min = 10000
  max = 99999
}

locals {
  common_tags = {
    Project     = "Azure Enterprise Cloud Platform"
    Environment = "Portfolio"
    Owner       = "Jamie Christian"
    Purpose     = "Cloud Engineering Portfolio"
  }
}

resource "azurerm_resource_group" "enterprise" {
  name     = var.resource_group_name
  location = var.location
  tags     = local.common_tags
}

resource "azurerm_virtual_network" "enterprise" {
  name                = var.virtual_network_name
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.enterprise.location
  resource_group_name = azurerm_resource_group.enterprise.name
  tags                = local.common_tags
}

resource "azurerm_subnet" "app" {
  name                 = var.app_subnet_name
  resource_group_name  = azurerm_resource_group.enterprise.name
  virtual_network_name = azurerm_virtual_network.enterprise.name
  address_prefixes     = ["10.0.0.0/24"]
}

resource "azurerm_network_security_group" "enterprise" {
  name                = var.network_security_group_name
  location            = azurerm_resource_group.enterprise.location
  resource_group_name = azurerm_resource_group.enterprise.name

  security_rule {
    name                       = "allow-http"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    description                = "Allow inbound HTTP traffic."
  }

  security_rule {
    name                       = "allow-https"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    description                = "Allow inbound HTTPS traffic."
  }

  tags = local.common_tags
}

resource "azurerm_subnet_network_security_group_association" "app" {
  subnet_id                 = azurerm_subnet.app.id
  network_security_group_id = azurerm_network_security_group.enterprise.id
}

resource "azurerm_storage_account" "enterprise_files" {
  name                            = "stenterprise${random_integer.suffix.result}"
  resource_group_name             = azurerm_resource_group.enterprise.name
  location                        = azurerm_resource_group.enterprise.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  access_tier                     = "Hot"
  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = false
  tags                            = local.common_tags
}

resource "azurerm_storage_container" "project_files" {
  name                  = "project-files"
  storage_account_name  = azurerm_storage_account.enterprise_files.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "logs" {
  name                  = "logs"
  storage_account_name  = azurerm_storage_account.enterprise_files.name
  container_access_type = "private"
}

resource "azurerm_service_plan" "enterprise" {
  name                = "asp-enterprise-free"
  resource_group_name = azurerm_resource_group.enterprise.name
  location            = azurerm_resource_group.enterprise.location
  os_type             = "Linux"
  sku_name            = "F1"
  tags                = local.common_tags
}

resource "azurerm_linux_web_app" "enterprise_app" {
  name                = "enterprise-app-demo-${random_integer.suffix.result}"
  resource_group_name = azurerm_resource_group.enterprise.name
  location            = azurerm_service_plan.enterprise.location
  service_plan_id     = azurerm_service_plan.enterprise.id
  https_only          = true

  site_config {
    always_on = false

    application_stack {
      node_version = "22-lts"
    }
  }

  app_settings = {
    "SCM_DO_BUILD_DURING_DEPLOYMENT" = "true"
    "WEBSITE_NODE_DEFAULT_VERSION"   = "~22"
    "STORAGE_ACCOUNT_NAME"           = azurerm_storage_account.enterprise_files.name
    "BLOB_CONTAINER_NAME"            = azurerm_storage_container.project_files.name
  }

  tags = local.common_tags
}

resource "azurerm_key_vault" "enterprise" {
  name                       = "kv-enterprise-${random_integer.suffix.result}"
  location                   = azurerm_resource_group.enterprise.location
  resource_group_name        = azurerm_resource_group.enterprise.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  soft_delete_retention_days = 90
  purge_protection_enabled   = false
  enable_rbac_authorization  = true
  tags                       = local.common_tags
}

resource "azurerm_role_assignment" "current_user_key_vault_admin" {
  scope                = azurerm_key_vault.enterprise.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_key_vault_secret" "db_password" {
  name         = "db-password"
  value        = var.demo_db_password
  key_vault_id = azurerm_key_vault.enterprise.id

  depends_on = [azurerm_role_assignment.current_user_key_vault_admin]
}

resource "azurerm_monitor_action_group" "cloud_ops" {
  name                = "cloud-ops-alert-group"
  resource_group_name = azurerm_resource_group.enterprise.name
  short_name          = "cloudops"
  tags                = local.common_tags
}

resource "azurerm_monitor_metric_alert" "web_app_requests" {
  name                = "enterprise-app-high-request-alert"
  resource_group_name = azurerm_resource_group.enterprise.name
  scopes              = [azurerm_linux_web_app.enterprise_app.id]
  description         = "Alert when total web app requests are greater than 5 in a 5-minute window."
  severity            = 3
  frequency           = "PT5M"
  window_size         = "PT5M"
  enabled             = true

  criteria {
    metric_namespace = "Microsoft.Web/sites"
    metric_name      = "Requests"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = 5
  }

  action {
    action_group_id = azurerm_monitor_action_group.cloud_ops.id
  }

  tags = local.common_tags
}
