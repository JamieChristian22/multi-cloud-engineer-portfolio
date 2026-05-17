resource "azurerm_service_plan" "this" { name=var.app_service_plan_name, resource_group_name=var.resource_group_name, location=var.location, os_type="Linux", sku_name="F1", tags=var.tags }
resource "azurerm_linux_web_app" "this" {
  name=var.web_app_name, resource_group_name=var.resource_group_name, location=azurerm_service_plan.this.location, service_plan_id=azurerm_service_plan.this.id, https_only=true, tags=var.tags
  site_config { always_on=false, application_stack { node_version="22-lts" } }
  app_settings = { APP_ENVIRONMENT=var.environment, STORAGE_ACCOUNT_NAME=var.storage_account_name, BLOB_CONTAINER_NAME=var.blob_container_name, KEY_VAULT_NAME=var.key_vault_name }
}
