# Terraform - Enterprise Web Platform

This Terraform package provides a portfolio-ready multi-cloud infrastructure baseline for the `01-enterprise-web-platform` project.

## What it includes

- AWS web platform baseline
- Azure web platform baseline
- GCP web platform baseline
- Reusable module layout
- Secure defaults
- Tags/labels for portfolio documentation
- Outputs for screenshots and evidence

## Recommended repo path

```text
01-enterprise-web-platform/
└── terraform/
    ├── aws/
    ├── azure/
    ├── gcp/
    └── modules/
```

## Usage

Pick one provider folder at a time.

```bash
cd terraform/aws
terraform init
terraform fmt
terraform validate
terraform plan
```

Only run `terraform apply` when you are ready to create resources and understand the cost.

## Evidence to capture

Add screenshots or terminal outputs to:

```text
evidence/screenshots/terraform/
```

Recommended evidence:

1. `terraform-init.png`
2. `terraform-validate.png`
3. `terraform-plan.png`
4. Cloud console resource group/project/VPC screenshots
5. `terraform-output.png`
6. `terraform-destroy-plan.png`

## Cost note

These templates are intentionally lightweight, but cloud resources can still create charges. Use `terraform destroy` after testing.
