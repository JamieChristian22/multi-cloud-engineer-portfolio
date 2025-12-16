# Azure Security Controls

## Implemented (Dev)
- Secrets stored in Container App secrets
- Central logging in Log Analytics
- Postgres backups enabled (7 days)

## Production Hardening Recommendations
- Use Managed Identity for Container App to pull from ACR
- Store DB password in Key Vault and reference it securely
- Disable public DB access and use private endpoints/VNet integration
- Add WAF in front of ingress (Front Door / App Gateway)
