output "storage_account_name" { value = azurerm_storage_account.this.name }
output "blob_container_name" { value = azurerm_storage_container.project_files.name }
output "tfstate_container_name" { value = azurerm_storage_container.tfstate.name }
