# Logging & Observability (Azure) — Complete Ops Pack

## Logging
- Azure Container Apps sends logs to the configured **Log Analytics Workspace**.
- Recommended KQL queries are included in `kql-queries.md`.

## Monitoring/Alerts
- Alert on:
  - HTTP 5xx trends (via logs)
  - High restart counts
  - Latency thresholds (if emitted)
- Add dashboards in Azure Monitor for service health.

## Runbook
See `runbook-oncall.md`.
