resource_group_name         = "rg-enterprise-infra"
location                    = "East US"
environment                 = "portfolio"

vnet_name                   = "vnet-enterprise"
vnet_address_space          = "10.0.0.0/16"

subnet_name                 = "app-subnet"
subnet_address_prefix       = "10.0.0.0/24"

network_security_group_name = "nsg-enterprise"

storage_account_name        = "stenterprisefiles"
blob_container_name         = "project-files"

key_vault_name              = "kv-enterprise-demo"

app_service_plan_name       = "ASP-rgenterpriseinfra-a004"
web_app_name                = "enterprise-app-demo"

alert_rule_name             = "webapp-requests-greater-than-5"

tags = {
  project        = "azure-enterprise-cloud-platform"
  environment    = "portfolio"
  owner          = "Jamie Christian"
  resource_group = "rg-enterprise-infra"
  cloud          = "Microsoft Azure"
  managed_by     = "Terraform"
}
