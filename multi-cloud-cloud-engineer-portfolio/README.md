# Multi-Cloud Cloud Engineer Portfolio (AWS + Azure + GCP)

This ZIP contains **three complete, no-placeholder** cloud engineering delivery packages—one per major cloud—to demonstrate:
- Infrastructure-as-Code (Terraform)
- Containerized deployment patterns
- Centralized logging/observability
- Security hardening + operational runbooks
- Cost optimization practices
- CI pipelines (GitHub Actions)

## Included Projects

1) **AWS** — `aws-customer-migration-modernization/`  
   Terraform + ECS Fargate + RDS + CloudWatch + Migration playbooks (MGN/CloudEndure + DMS)

2) **Azure** — `azure-app-modernization-container-apps/`  
   Terraform + Azure Container Apps + ACR + PostgreSQL Flexible Server + Log Analytics + alerts

3) **GCP** — `gcp-app-modernization-cloud-run/`  
   Terraform + Cloud Run + Artifact Registry + Cloud SQL Postgres + Cloud Logging + monitoring alert policy

> Each project is designed to stand alone (own docs, pipelines, app, scripts).

## How to Use
Open any project folder and follow its `README.md` Quick Start.

## Note on Secrets
Projects include secure patterns (Key Vault / Secret Manager), but also provide a simple default for local testing.
Replace defaults before real deployment.
