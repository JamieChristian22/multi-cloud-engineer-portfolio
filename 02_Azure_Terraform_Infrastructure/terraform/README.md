# 02_Azure_Terraform_Infrastructure

## Project Overview
This is a filled, modular Terraform IaC implementation for the Azure Enterprise Cloud Platform portfolio. It includes provider configuration, remote backend state, reusable modules, `.gitignore`, and GitHub Actions CI/CD.

## Folder Structure
```text
02_Azure_Terraform_Infrastructure/
├── README.md
├── backend.tf
├── providers.tf
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
├── .gitignore
└── modules/
    ├── resource_group/
    ├── networking/
    ├── storage/
    ├── key_vault/
    ├── app_service/
    └── monitoring/
```

## GitHub Actions CI/CD
Workflow path:
```text
.github/workflows/azure-terraform-cicd.yml
```
The workflow runs Terraform format checks, init, validate, plan, and a controlled manual apply from the main branch.

## Actual Project Values
| Item | Value |
|---|---|
| Resource Group | rg-enterprise-infra |
| Region | East US |
| VNet | vnet-enterprise |
| Subnet | app-subnet |
| NSG | nsg-enterprise |
| Storage Account | stenterprisefiles |
| Blob Container | project-files |
| Terraform State Container | tfstate |
| Key Vault | kv-enterprise-demo |
| App Service Plan | ASP-rgenterpriseinfra-a004 |
| Web App | enterprise-app-demo |
| Runtime | Node.js 22 LTS |
| Alert Rule | webapp-requests-greater-than-5 |

## Commands
```bash
terraform init
terraform fmt -recursive
terraform validate
terraform plan
terraform apply
```

## GitHub Secrets Used for CI/CD
```text
AZURE_CLIENT_ID
AZURE_TENANT_ID
AZURE_SUBSCRIPTION_ID
```
These are secure CI/CD authentication values and should stay in GitHub repository secrets, not inside source code.
