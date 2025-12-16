# Recommended remote state backend (Azure Storage). Create using scripts/bootstrap_backend.sh

terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate-jamie"
    storage_account_name = "sttfstatejamie"
    container_name       = "tfstate"
    key                  = "azure-container-apps/dev.tfstate"
  }
}
