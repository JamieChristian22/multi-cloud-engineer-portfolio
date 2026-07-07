# 05 Disaster Recovery Platform - Terraform

Multi-cloud Terraform starter for a portfolio-ready disaster recovery platform across AWS, Azure, and GCP.

## What this builds

- Backup vaults / recovery vault foundations
- Object storage for DR evidence and recovery artifacts
- Cross-region replication patterns
- Monitoring hooks for DR readiness
- Environment-based variables for dev and prod
- Security-first tagging, encryption, and lifecycle defaults

## Folder structure

```text
terraform/
├── aws/
├── azure/
├── gcp/
├── modules/
├── environments/
├── docs/
└── scripts/
```

## Recommended workflow

```bash
cd terraform/aws
terraform init
terraform fmt -recursive
terraform validate
terraform plan -var-file=../environments/dev/aws.tfvars
```

Repeat the same pattern for `azure/` and `gcp/`.

## Portfolio evidence to capture

- Terraform init / validate / plan screenshots
- Backup vault screenshots
- Storage bucket / container screenshots
- Replication or lifecycle policy screenshots
- Monitoring alert screenshots
- Cost estimate screenshots
- README explanation of RTO and RPO

## DR design goals

| Goal | Meaning |
|---|---|
| RTO | How fast systems should recover |
| RPO | How much data loss is acceptable |
| Backup | Point-in-time recovery protection |
| Replication | Copies data to another region/cloud |
| Runbook | Step-by-step recovery process |
| Validation | Testing recovery before a real incident |
```
