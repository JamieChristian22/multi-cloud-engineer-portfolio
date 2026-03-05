# Secrets Strategy (No Static Keys)

## Preferred Options
- AWS: Secrets Manager + IRSA for retrieval
- Azure: Key Vault + Managed Identity
- GCP: Secret Manager + Workload Identity

## Optional Unified Approach
- HashiCorp Vault (Kubernetes auth) issuing dynamic credentials where supported.

## CI/CD Hardening
- never echo secrets
- restrict PAT scopes
- rotate every 30 days
- use OIDC where possible for cloud auth
