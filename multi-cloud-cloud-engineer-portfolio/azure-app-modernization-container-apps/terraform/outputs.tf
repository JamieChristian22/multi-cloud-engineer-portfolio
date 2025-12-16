output "container_app_fqdn" {
  value       = azurerm_container_app.app.latest_revision_fqdn
  description = "Public FQDN for the Container App"
}

output "acr_login_server" {
  value       = azurerm_container_registry.acr.login_server
  description = "ACR login server"
}

output "postgres_fqdn" {
  value       = azurerm_postgresql_flexible_server.pg.fqdn
  description = "PostgreSQL server FQDN"
}
