# Azure Operations Runbook

## Smoke Test
- `https://<container_app_fqdn>/health` -> 200
- `https://<container_app_fqdn>/ready` -> 200 when DB reachable

## Logs
- Azure Portal -> Log Analytics Workspace -> Logs
- Query container logs and check for DB connection errors

## Common Issues
1) Image pull failure
- Ensure you ran `scripts/push_image_to_acr.sh`
- Verify registry credentials configured (Terraform uses ACR admin in dev)

2) DB connectivity errors
- Verify Postgres firewall rules
- Confirm DB_USER format: `<user>@<server>`
- Confirm secrets: DB_PASS
