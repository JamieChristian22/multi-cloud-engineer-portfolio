# Validation Commands - Storage and Data Platform

## AWS
```bash
aws s3api get-bucket-versioning --bucket <bucket-name>
aws s3api get-public-access-block --bucket <bucket-name>
aws s3api get-bucket-encryption --bucket <bucket-name>
```

## Azure
```bash
az storage account show --name <storage-account> --resource-group <rg>
az storage container show --name enterprise-data --account-name <storage-account>
```

## GCP
```bash
gcloud storage buckets describe gs://<bucket-name>
```
