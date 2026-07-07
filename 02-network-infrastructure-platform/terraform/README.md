# 02 Network Infrastructure Platform - Terraform

Production-style multi-cloud network infrastructure for AWS, Azure, and GCP.

## What this builds

- AWS VPC with public/private subnets, route tables, internet gateway, security group, VPC flow logs placeholders
- Azure VNet with public/private/app subnets and NSG rules
- GCP VPC with regional subnets and firewall rules
- Reusable Terraform modules for each cloud
- Dev/prod variable examples
- Validation and cleanup scripts

## Folder structure

```text
terraform/
├── aws/
├── azure/
├── gcp/
├── modules/
│   ├── aws-network/
│   ├── azure-network/
│   └── gcp-network/
├── envs/
│   ├── dev/
│   └── prod/
├── docs/
└── scripts/
```

## How to use

Choose a cloud folder, copy the matching `.tfvars.example` values, then run:

```bash
terraform init
terraform fmt -recursive
terraform validate
terraform plan -var-file="../envs/dev/aws.tfvars.example"
```

For Azure:

```bash
terraform plan -var-file="../envs/dev/azure.tfvars.example"
```

For GCP:

```bash
terraform plan -var-file="../envs/dev/gcp.tfvars.example"
```

## Portfolio evidence to capture

- `terraform init` success
- `terraform validate` success
- `terraform plan` output
- Cloud console screenshots of VPC/VNet, subnets, route tables, firewall/security rules
- Cleanup proof after `terraform destroy`

## Safety

These files are portfolio-ready templates. Review variables before applying to avoid unexpected cloud costs.
