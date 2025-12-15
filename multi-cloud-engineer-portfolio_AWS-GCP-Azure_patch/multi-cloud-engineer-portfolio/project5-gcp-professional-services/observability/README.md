# Logging & Observability (GCP) — Complete Ops Pack

## Logging
- Cloud Run automatically ships stdout/stderr to **Cloud Logging**.
- Recommended log-based metrics:
  - 5xx responses (if app emits status codes in logs)
  - latency warnings
- Retention and sinks:
  - Set retention per compliance requirements
  - Export critical logs to a central project/bucket if needed

## Monitoring
- Create alerting policies:
  - Request latency p95 threshold
  - Error rate threshold
  - Container instance utilization (where applicable)

## Runbook
See `runbook-oncall.md`.
