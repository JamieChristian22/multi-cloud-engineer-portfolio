# Azure App Modernization (Terraform + Azure Container Apps + PostgreSQL Flexible Server)

A complete Azure delivery package demonstrating:
- Terraform-based Azure provisioning
- Azure Container Apps deployment pulling image from ACR
- PostgreSQL Flexible Server (private/public toggle via variables)
- Centralized logging via Log Analytics + Container App logs
- Basic alerting via Azure Monitor scheduled query rule
- Runbook + verification plan
- GitHub Actions pipeline (fmt/validate/plan/apply)

## Architecture

```text
Internet -> Azure Container App (HTTP) -> PostgreSQL Flexible Server
                      |
                      v
              Log Analytics Workspace
```

## Prerequisites
- Azure subscription
- Azure CLI logged in (`az login`)
- Terraform >= 1.5
- A GitHub repo with Actions enabled (optional)

## Quick Start (Local)
1) Bootstrap remote state (optional but recommended):
```bash
bash scripts/bootstrap_backend.sh
```

2) Deploy:
```bash
bash scripts/deploy_local.sh
```

3) Verify:
- Terraform output `container_app_fqdn`
- `https://<fqdn>/health`

4) Destroy:
```bash
bash scripts/destroy_local.sh
```

## CI/CD
See `.github/workflows/` for plan/apply workflows using OIDC.

## Deliverables
- `terraform/` IaC
- `app/` Flask API + Dockerfile
- `docs/` design + runbook + security + cost + testing
- `evidence/` sample outputs
