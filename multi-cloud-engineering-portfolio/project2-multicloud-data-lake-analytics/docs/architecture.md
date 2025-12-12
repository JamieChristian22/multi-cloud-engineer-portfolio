# Architecture – Multi‑Cloud Data Lake & Analytics Orchestration

## Goal

Provide a realistic but lightweight project that demonstrates:

- Multi‑cloud ingestion into:
  - **Amazon S3**
  - **Azure Data Lake Storage Gen2**
  - **Google Cloud Storage**
- A single, configurable Python ETL script.

---

## Components

### Local

- Python script: `multicloud_ingest.py`
- Source data: local CSV files (`transactions.csv`, etc.)

### AWS

- S3 bucket for raw data (e.g., `mc-data-lake-aws`)
- Optional: Athena table to query the ingested files.

### Azure

- Storage account with hierarchical namespaces enabled (ADLS Gen2)
- Container for raw data (e.g., `raw`)
- Optional: Synapse / Serverless SQL external table.

### GCP

- GCS bucket for raw data (e.g., `mc-data-lake-gcp`)
- Optional: BigQuery external table on GCS URI.

---

## Flow

1. **Load CSV**
   - Read the file into memory as rows.
   - Normalize headers (snake_case, no spaces).
   - Add a new column `ingested_at`.

2. **Determine Target Provider**
   - Read `TARGET_PROVIDER` (`aws`, `azure`, or `gcp`).

3. **Upload to Cloud**

   **AWS**
   - Use `boto3.client("s3")`.
   - Put object: `s3.put_object(Bucket=bucket, Key=key, Body=data)`.

   **Azure**
   - Use `BlobServiceClient` from `azure.storage.blob`.
   - Upload to container: `blob_client.upload_blob(data, overwrite=True)`.

   **GCP**
   - Use `google.cloud.storage.Client`.
   - Upload blob: `bucket.blob(key).upload_from_string(data)`.

4. **Result**

   - The script prints the fully qualified URI:
     - `s3://bucket/key`
     - `https://account.blob.core.windows.net/container/key`
     - `gs://bucket/key`

---

## Extensibility

In an interview, you can confidently talk about:

- Adding **partitioning** (e.g., `year=2025/month=12/day=11/...`).
- Logging, error handling, and retries.
- Orchestrating this job with:
  - AWS Step Functions or EventBridge Scheduler
  - Azure Data Factory
  - Cloud Composer / Cloud Scheduler

This project is intentionally focused but fully functional, making it perfect for a portfolio.
