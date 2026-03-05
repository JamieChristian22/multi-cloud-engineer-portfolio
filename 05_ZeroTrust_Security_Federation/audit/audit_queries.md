# Audit Queries & Alerts

## AWS CloudTrail
Flag high risk:
- `iam:PassRole`
- `kms:Decrypt` spikes
- `s3:DeleteObject`

## Azure Activity Log
Watch:
- role assignment changes
- key vault secret reads outside normal window

## GCP Cloud Audit Logs
Watch:
- service account key creation
- storage deletions
- bigquery dataset permission changes
