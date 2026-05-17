output "app_service_plan_name" { value = azurerm_service_plan.this.name }
output "web_app_name" { value = azurerm_linux_web_app.this.name }
output "web_app_id" { value = azurerm_linux_web_app.this.id }
output "web_app_url" { value = "https://${azurerm_linux_web_app.this.default_hostname}" }
