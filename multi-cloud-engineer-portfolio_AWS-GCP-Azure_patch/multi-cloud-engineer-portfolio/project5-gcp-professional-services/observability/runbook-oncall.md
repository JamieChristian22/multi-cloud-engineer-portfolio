# On-Call Runbook (Cloud Run)

## 1) Service Unavailable
- Check Cloud Run revisions and recent deploy events
- Inspect Cloud Logging for the latest revision
- Validate container port (3000) and health behavior

## 2) High Latency
- Check Cloud Monitoring latency charts
- Review recent deploys and traffic split
- Scale controls: Cloud Run scales automatically; check max instances

## Rollback
- Route traffic back to previous revision (Cloud Run traffic splitting)
