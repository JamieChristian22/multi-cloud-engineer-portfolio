# GCP Security Controls

## Implemented (Dev)
- DB password stored in Secret Manager
- Cloud Run service account least-privilege secret access
- Cloud SQL backups enabled

## Production Hardening
- Remove `allUsers` invoker, enforce authenticated invokers
- Restrict Cloud SQL networking (private IP)
- Add Cloud Armor policy if using HTTPS LB in front
- Add audit log sinks and retention policies
