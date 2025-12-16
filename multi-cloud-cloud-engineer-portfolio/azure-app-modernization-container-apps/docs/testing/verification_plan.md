# Azure Verification Plan

- Terraform apply succeeds
- ACR exists and app image is pushed
- Container App starts and is reachable via FQDN
- `/health` returns 200
- `/ready` returns 200 once DB is reachable
- Logs present in Log Analytics
