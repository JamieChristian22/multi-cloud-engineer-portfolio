# GitHub Actions Terraform CI/CD

This workflow automatically runs Terraform validation checks whenever code is pushed to the repository.

## Included Checks
- terraform fmt -check
- terraform init
- terraform validate
- terraform plan

## Purpose
This CI/CD workflow helps ensure:
- Infrastructure code quality
- Terraform syntax validation
- Deployment consistency
- Early detection of infrastructure issues

## Workflow Location
.github/workflows/terraform.yml