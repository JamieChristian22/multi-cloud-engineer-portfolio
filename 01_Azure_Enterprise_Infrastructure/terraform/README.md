# Terraform Infrastructure as Code

This folder contains Infrastructure as Code for the Azure Enterprise Cloud Platform portfolio project.

## What This Deploys
- Resource Group: `rg-enterprise-infra`
- Virtual Network: `vnet-enterprise`
- Subnet: `app-subnet`
- Network Security Group: `nsg-enterprise`
- NSG Rules:
  - `allow-http` on port 80
  - `allow-https` on port 443
- Azure Storage Account
- Blob Containers:
  - `project-files`
  - `logs`
- Linux Azure App Service Plan using free-tier `F1`
- Linux Web App using Node.js 22 LTS
- Azure Key Vault
- Key Vault Secret: `db-password`
- Azure Monitor Metric Alert for web app requests

## Commands
```bash
az login
terraform init
terraform validate
terraform plan
terraform apply
terraform output
```

## Purpose
This Terraform setup mirrors the Azure portal build documented in the screenshots and turns the portfolio project into repeatable Infrastructure as Code.
