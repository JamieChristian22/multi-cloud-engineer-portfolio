module "azure_network" {
  source = "../modules/azure-network"

  location            = var.location
  project_name        = var.project_name
  environment         = var.environment
  vnet_address_space  = var.vnet_address_space
  subnets             = var.subnets
  allowed_admin_cidr  = var.allowed_admin_cidr
}
