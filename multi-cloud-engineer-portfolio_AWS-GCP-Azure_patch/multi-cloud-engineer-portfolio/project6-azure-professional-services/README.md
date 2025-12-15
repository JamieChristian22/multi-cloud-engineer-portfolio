# Project 6 — Azure Professional Services Delivery (Terraform + CI/CD + Containers + Logging + Security + Cost + Migration)

This project mirrors real customer-facing Cloud Engineer work on **Microsoft Azure**.

## What you deploy (Azure)
- Resource Group
- Azure Container Registry (ACR)
- Log Analytics Workspace (central logs)
- Azure Container Apps environment + app (container deployment)

## How to run (Dev)
```bash
cd terraform/envs/dev
terraform init
terraform plan
terraform apply
```

### Required inputs (set once via `terraform.tfvars`)
- `subscription_id`
- `tenant_id`
- `location` (default: eastus)

## CI/CD
- Terraform CI: fmt/validate/plan
- Docker CI: build + push to ACR

### GitHub Secrets (for Docker CI)
- `AZURE_CREDENTIALS` (JSON for azure/login)
- `ACR_LOGIN_SERVER`, `ACR_USERNAME`, `ACR_PASSWORD`, `ACR_IMAGE_URI`
