# Troubleshooting Guide

## Terraform provider fails to initialize

Run:

```bash
terraform init -upgrade
```

## App Service F1 SKU is unavailable

Some subscriptions or regions may not allow the F1 SKU. Change this in `terraform.tfvars`:

```hcl
app_service_sku = "B1"
```

Then run:

```bash
terraform plan -out=tfplan
terraform apply tfplan
```

## Storage account name already exists

Azure Storage Account names must be globally unique. This project adds a random suffix. If a collision occurs, run:

```bash
terraform destroy
terraform apply
```

## Key Vault name conflict

Key Vault names must also be globally unique. The random suffix normally prevents conflicts. Re-run the deployment if needed.

## Azure login issue

Run:

```bash
az logout
az login
az account set --subscription "<subscription-id>"
```

## Cleanup issue

If Terraform destroy fails, delete the resource group from Azure Portal or use:

```bash
az group delete --name <resource-group-name> --yes --no-wait
```
