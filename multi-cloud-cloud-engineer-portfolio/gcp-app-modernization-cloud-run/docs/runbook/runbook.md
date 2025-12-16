# GCP Operations Runbook

## Smoke Test
- `curl <service_url>/health` -> 200
- `curl <service_url>/ready` -> 200 once DB reachable

## Logs
- Cloud Logging -> Logs Explorer
- Filter by Cloud Run service name and inspect startup/errors

## Common Issues
1) Cloud SQL connectivity
- If using public IP in dev, confirm authorized networks include your source
- For prod, use private IP + VPC connector
2) Image push/auth problems
- Run `gcloud auth configure-docker <region>-docker.pkg.dev`
