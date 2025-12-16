# GCP Verification Plan

- Terraform apply succeeds, APIs enabled
- Artifact Registry repo exists
- Cloud SQL instance + database + user created
- Secret Manager secret created and accessible by Cloud Run SA
- Cloud Run service deployed and reachable at `service_url`
- `/health` returns 200
- Logs visible in Cloud Logging
