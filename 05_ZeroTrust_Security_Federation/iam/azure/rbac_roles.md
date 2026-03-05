# Azure RBAC (Managed Identity)

## Scope
Resource Group: `rg-mc-observability-prod`

## Role Assignments
- Managed Identity: `mi-mc-microservices-prod`
  - **Monitoring Metrics Publisher** (send custom metrics)
  - **Storage Blob Data Reader** on `stmcanalyticsprod` container `analytics`

## Commands (Az CLI)
```bash
az role assignment create   --assignee-object-id <MANAGED_IDENTITY_OBJECT_ID>   --role "Monitoring Metrics Publisher"   --scope /subscriptions/<SUB_ID>/resourceGroups/rg-mc-observability-prod
```
