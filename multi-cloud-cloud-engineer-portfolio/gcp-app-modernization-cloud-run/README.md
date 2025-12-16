# GCP App Modernization (Terraform + Cloud Run + Cloud SQL Postgres + Cloud Logging)

A complete GCP delivery package demonstrating:
- Terraform provisioning
- Cloud Run deployment (container)
- Artifact Registry for images
- Cloud SQL Postgres + user/database
- Secret Manager for DB password
- Monitoring alert policy (basic)
- Runbook + verification plan
- GitHub Actions pipeline (fmt/validate/plan/apply + build/push/deploy)

## Architecture

```text
Internet -> Cloud Run Service -> Cloud SQL Postgres
                 |
                 v
           Cloud Logging/Monitoring
```

## Prerequisites
- GCP project with billing enabled
- `gcloud auth application-default login`
- Terraform >= 1.5
- Docker

## Quick Start (Local)
1) Deploy infra:
```bash
bash scripts/deploy_local.sh
```

2) Build & deploy app:
```bash
bash scripts/build_push_deploy.sh
```

3) Verify:
- Terraform output `service_url`
- `curl <service_url>/health`

4) Destroy:
```bash
bash scripts/destroy_local.sh
```
