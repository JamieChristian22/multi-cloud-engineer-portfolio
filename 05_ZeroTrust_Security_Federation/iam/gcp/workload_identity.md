# GCP Workload Identity Federation (Kubernetes → GCP)

## Target
- GCP Project: `mc-prod-analytics-2026`
- Service Account: `sa-mc-microservices-prod@mc-prod-analytics-2026.iam.gserviceaccount.com`

## IAM Binding (gcloud)
```bash
gcloud iam service-accounts add-iam-policy-binding   sa-mc-microservices-prod@mc-prod-analytics-2026.iam.gserviceaccount.com   --role roles/iam.workloadIdentityUser   --member "serviceAccount:mc-prod-analytics-2026.svc.id.goog[mc-prod/order-service]"
```

## Permissions on BigQuery dataset
- `roles/bigquery.dataEditor` on dataset `analytics`
