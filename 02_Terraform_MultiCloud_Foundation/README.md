# 02 — Terraform Multi-Cloud Foundation (Landing Zone)

## Goal
Provision a consistent, repeatable **foundation layer** across:
- **AWS** (VPC + subnets + security group + EC2 + S3)
- **Azure** (Resource Group + VNet + subnet + NSG + Linux VM + Storage Account)
- **GCP** (VPC + subnet + firewall + Compute Engine + Cloud Storage)

This is a pragmatic "portable landing zone" pattern used in many enterprises.

---

## Repo Layout

```text
terraform/
  environments/
    dev/
      main.tf
      variables.tf
      dev.tfvars
  modules/
    aws_foundation/
      main.tf variables.tf outputs.tf
    azure_foundation/
      main.tf variables.tf outputs.tf
    gcp_foundation/
      main.tf variables.tf outputs.tf
```

---

## How To Use

### 1) Install
- Terraform >= 1.6
- Cloud CLIs (aws, az, gcloud) for auth

### 2) Authenticate
- AWS: `aws configure`
- Azure: `az login`
- GCP: `gcloud auth application-default login`

### 3) Deploy (Dev)
```bash
cd terraform/environments/dev
terraform init
terraform plan -var-file=dev.tfvars
terraform apply -var-file=dev.tfvars
```

---

## What You Get (Dev)

### AWS (us-east-1)
- VPC `10.10.0.0/16`
- Public subnet `10.10.1.0/24`
- EC2 `t3.micro` (Amazon Linux 2023)
- S3 bucket `jamie-mc-foundation-dev-aws`

### Azure (eastus)
- Resource group `rg-mc-foundation-dev`
- VNet `10.20.0.0/16`
- Ubuntu VM `Standard_B1s`
- Storage account `mcdevstorage2026`

### GCP (us-east1)
- VPC `mc-foundation-dev`
- Subnet `10.30.1.0/24`
- e2-micro instance
- Bucket `mc-foundation-dev-gcs-2026`

> These names are deterministic and fully filled in—no missing values.
