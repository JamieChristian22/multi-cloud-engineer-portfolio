terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.116"
    }
  }
}

provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "enterprise" {
  name     = var.resource_group_name
  location = var.location

  tags = var.tags
}

resource "azurerm_virtual_network" "enterprise" {
  name                = var.vnet_name
  location            = azurerm_resource_group.enterprise.location
  resource_group_name = azurerm_resource_group.enterprise.name
  address_space       = [var.vnet_address_space]

  tags = var.tags
}

resource "azurerm_subnet" "app" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.enterprise.name
  virtual_network_name = azurerm_virtual_network.enterprise.name
  address_prefixes     = [var.subnet_address_prefix]
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
  }

  tags = var.tags
}

resource "azurerm_subnet_network_security_group_association" "app_subnet_nsg" {
  subnet_id                 = azurerm_subnet.app.id
  network_security_group_id = azurerm_network_security_group.enterprise.id
}

resource "azurerm_storage_account" "enterprise" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.enterprise.name
  location                 = azurerm_resource_group.enterprise.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  access_tier              = "Hot"
  min_tls_version          = "TLS1_2"

  allow_nested_items_to_be_public = false

  tags = var.tags
}

resource "azurerm_storage_container" "project_files" {
  name                  = var.blob_container_name
  storage_account_name  = azurerm_storage_account.enterprise.name
  container_access_type = "private"
}

resource "azurerm_key_vault" "enterprise" {
  name                       = var.key_vault_name
  location                   = azurerm_resource_group.enterprise.location
  resource_group_name        = azurerm_resource_group.enterprise.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  soft_delete_retention_days = 90
  purge_protection_enabled   = false
  enable_rbac_authorization  = true

  tags = var.tags
}

resource "azurerm_service_plan" "enterprise" {
  name                = var.app_service_plan_name
  resource_group_name = azurerm_resource_group.enterprise.name
  location            = azurerm_resource_group.enterprise.location
  os_type             = "Linux"
  sku_name            = "F1"

  tags = var.tags
}

resource "azurerm_linux_web_app" "enterprise" {
  name                = var.web_app_name
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
    APP_ENVIRONMENT      = var.environment
    STORAGE_ACCOUNT_NAME = azurerm_storage_account.enterprise.name
    KEY_VAULT_NAME       = azurerm_key_vault.enterprise.name
    BLOB_CONTAINER_NAME  = azurerm_storage_container.project_files.name
  }

  tags = var.tags
}

resource "azurerm_monitor_metric_alert" "web_app_requests" {
  name                = var.alert_rule_name
  resource_group_name = azurerm_resource_group.enterprise.name
  scopes              = [azurerm_linux_web_app.enterprise.id]
  description         = "Alert when web app request count is greater than 5 in a 5-minute window."
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

  tags = var.tags
}
