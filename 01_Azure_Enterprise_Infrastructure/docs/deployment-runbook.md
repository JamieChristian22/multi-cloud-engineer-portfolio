# Deployment Runbook

## Purpose

This runbook provides the operational steps to deploy, validate, and remove the Azure Enterprise Infrastructure project.

## Deployment Steps

```bash
cd terraform
terraform init
terraform fmt -recursive
terraform validate
terraform plan -out=tfplan
terraform apply tfplan
terraform output
```

## Post-Deployment Validation

1. Confirm the Resource Group exists in the Azure Portal.
2. Open the Web App URL from `terraform output web_app_url`.
3. Confirm the Storage Account has secure transfer enabled.
4. Confirm the blob container is private.
5. Confirm Key Vault uses RBAC authorization.
6. Confirm Application Insights is connected to the Web App.
7. Confirm the Azure Monitor metric alert exists.
8. Save screenshots in the `screenshots/` folder.

## Cleanup

```bash
terraform destroy
```

Alternative resource group cleanup:

```bash
../scripts/cleanup_resources.sh <resource-group-name>
```
