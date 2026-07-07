# 03-storage-and-data-platform Terraform

Production-style multi-cloud Terraform for the **Storage and Data Platform** project.

## What this builds

- AWS S3 secure data lake bucket
- Azure Storage Account + private container
- Google Cloud Storage bucket
- Encryption, versioning, lifecycle rules, public-access blocking, tagging/labels
- Dev/prod variable examples
- Validation and cleanup scripts

## Folder structure

```text
terraform/
├── aws/
├── azure/
├── gcp/
├── modules/
│   ├── aws-storage/
│   ├── azure-storage/
│   └── gcp-storage/
├── envs/
│   ├── dev/
│   └── prod/
├── docs/
└── scripts/
```

## Usage

Choose a cloud provider folder, update `terraform.tfvars`, then run:

```bash
terraform init
terraform fmt -recursive
terraform validate
terraform plan
terraform apply
```

## Portfolio evidence to capture

- Terraform init/plan/apply output
- Storage bucket/account created
- Encryption enabled
- Versioning enabled
- Lifecycle policy configured
- Public access blocked
- IAM/RBAC/service account permissions
- Cleanup/destroy output

