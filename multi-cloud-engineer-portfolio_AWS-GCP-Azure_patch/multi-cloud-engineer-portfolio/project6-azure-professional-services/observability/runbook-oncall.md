# On-Call Runbook (Azure Container Apps)

## 1) Service Errors
- Check Container App revision health
- Review Log Analytics logs (KQL queries in kql-queries.md)
- Confirm ingress target port is 3000

## 2) Rollback
- If using multiple revisions, route traffic to a known-good revision
- For Single revision mode: redeploy a previous image tag and restart revision
