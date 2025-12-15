# Project 5 — GCP Professional Services Delivery (Terraform + CI/CD + Containers + Logging + Security + Cost + Migration)

This project mirrors real customer-facing Cloud Engineer work on **Google Cloud**.

## What you deploy (GCP)
- VPC Network + Subnet
- Artifact Registry (Docker)
- Cloud Run service (container deployment)
- Cloud Logging (Cloud Run logs) + Monitoring guidance

## How to run (Dev)
```bash
cd terraform/envs/dev
terraform init
terraform plan
terraform apply
```

### Required inputs (set once via `terraform.tfvars`)
- `project_id` (your GCP project)
- `region` (default: us-central1)

## CI/CD
- Terraform CI: fmt/validate/plan
- Docker CI: build + push to Artifact Registry

### GitHub Secrets (for Docker CI)
- `GCP_SA_KEY_JSON` (service account key JSON with Artifact Registry push permissions)
- `GCP_ARTIFACT_REGISTRY_HOST` (example: us-central1-docker.pkg.dev)
- `GCP_IMAGE_URI` (example: us-central1-docker.pkg.dev/<project>/<repo>/app)
