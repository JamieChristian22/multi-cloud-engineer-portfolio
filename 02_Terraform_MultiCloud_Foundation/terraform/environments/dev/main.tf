terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws = { source = "hashicorp/aws", version = "~> 5.0" }
    azurerm = { source = "hashicorp/azurerm", version = "~> 3.0" }
    google = { source = "hashicorp/google", version = "~> 5.0" }
  }
}

provider "aws" {
  region = var.aws_region
}

provider "azurerm" {
  features {}
}

provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
}

module "aws_foundation" {
  source        = "../../modules/aws_foundation"
  name_prefix   = var.name_prefix
  vpc_cidr      = "10.10.0.0/16"
  subnet_cidr   = "10.10.1.0/24"
  instance_type = "t3.micro"
  bucket_name   = "jamie-mc-foundation-dev-aws"
  allowed_ssh_cidr = var.allowed_ssh_cidr
}

module "azure_foundation" {
  source          = "../../modules/azure_foundation"
  name_prefix     = var.name_prefix
  location        = var.azure_location
  vnet_cidr       = "10.20.0.0/16"
  subnet_cidr     = "10.20.1.0/24"
  vm_size         = "Standard_B1s"
  admin_username  = "mcadmin"
  storage_account_name = "mcdevstorage2026"
  allowed_ssh_cidr = var.allowed_ssh_cidr
}

module "gcp_foundation" {
  source        = "../../modules/gcp_foundation"
  name_prefix   = var.name_prefix
  project_id    = var.gcp_project_id
  region        = var.gcp_region
  network_name  = "mc-foundation-dev"
  subnet_cidr   = "10.30.1.0/24"
  machine_type  = "e2-micro"
  bucket_name   = "mc-foundation-dev-gcs-2026"
  allowed_ssh_cidr = var.allowed_ssh_cidr
}

output "aws_outputs"   { value = module.aws_foundation }
output "azure_outputs" { value = module.azure_foundation }
output "gcp_outputs"   { value = module.gcp_foundation }
