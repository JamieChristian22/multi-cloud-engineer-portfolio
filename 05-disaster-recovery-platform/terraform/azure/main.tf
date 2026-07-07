terraform {
  required_version = ">= 1.6.0"
}

provider "azurerm" {
  features {}
}

locals {
  name_prefix = "${var.project_name}-${var.environment}"
  tags = {
    project     = var.project_name
    environment = var.environment
    managed_by  = "Terraform"
    purpose     = "DisasterRecovery"
    owner       = var.owner
  }
}

resource "azurerm_resource_group" "primary" {
  name     = "rg-${local.name_prefix}-primary"
  location = var.primary_location
  tags     = local.tags
}

resource "azurerm_resource_group" "dr" {
  name     = "rg-${local.name_prefix}-dr"
  location = var.dr_location
  tags     = local.tags
}

resource "azurerm_recovery_services_vault" "primary" {
  name                = "rsv-${local.name_prefix}-primary"
  location            = azurerm_resource_group.primary.location
  resource_group_name = azurerm_resource_group.primary.name
  sku                 = "Standard"
  storage_mode_type   = "GeoRedundant"
  soft_delete_enabled = true
  tags                = local.tags
}

resource "azurerm_backup_policy_vm" "daily" {
  name                = "bp-${local.name_prefix}-daily"
  resource_group_name = azurerm_resource_group.primary.name
  recovery_vault_name = azurerm_recovery_services_vault.primary.name

  timezone = var.timezone

  backup {
    frequency = "Daily"
    time      = var.backup_time
  }

  retention_daily {
    count = var.daily_retention_days
  }

  retention_weekly {
    count    = var.weekly_retention_weeks
    weekdays = ["Sunday"]
  }
}

resource "azurerm_storage_account" "dr_artifacts" {
  name                     = lower(replace("st${var.environment}dr${var.unique_suffix}", "-", ""))
  resource_group_name      = azurerm_resource_group.primary.name
  location                 = azurerm_resource_group.primary.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  min_tls_version          = "TLS1_2"

  blob_properties {
    versioning_enabled = true
    delete_retention_policy {
      days = var.blob_delete_retention_days
    }
    container_delete_retention_policy {
      days = var.blob_delete_retention_days
    }
  }

  tags = local.tags
}

resource "azurerm_storage_container" "runbooks" {
  name                  = "dr-runbooks"
  storage_account_name  = azurerm_storage_account.dr_artifacts.name
  container_access_type = "private"
}

resource "azurerm_log_analytics_workspace" "dr" {
  name                = "law-${local.name_prefix}-dr"
  location            = azurerm_resource_group.primary.location
  resource_group_name = azurerm_resource_group.primary.name
  sku                 = "PerGB2018"
  retention_in_days   = var.log_retention_days
  tags                = local.tags
}

resource "azurerm_monitor_action_group" "dr_ops" {
  name                = "ag-${local.name_prefix}-dr-ops"
  resource_group_name = azurerm_resource_group.primary.name
  short_name          = "dr-ops"
}
