terraform {
  backend "azurerm" {
    resource_group_name  = "rg-enterprise-infra"
    storage_account_name = "stenterprisefiles"
    container_name       = "tfstate"
    key                  = "02-azure-terraform-infrastructure/terraform.tfstate"
  }
}
