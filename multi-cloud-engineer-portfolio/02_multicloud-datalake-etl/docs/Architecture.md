# 🏗 Architecture – Multi-Cloud Data Lake & ETL

The ETL pipeline follows a **zone-based data lake** pattern and abstracts cloud providers behind a common interface.

---

## 1. Flow

1. Read CSV files from an input directory or bucket.
2. Optionally validate and enrich records (e.g., add ingestion timestamp).
3. Write files to a cloud bucket/container:
   - `landing/` for raw ingested files
   - `raw/` for lightly cleaned data
   - `processed/` for aggregates or optimized formats (optional)

---

## 2. Storage Client Abstraction

The code defines a `StorageClient` interface with methods such as:

- `upload_file(local_path, target_path)`
- `list_objects(prefix)`
- `download_file(object_path, local_target)`

Concrete implementations:

- `AwsStorageClient(StorageClient)` using `boto3`
- `AzureStorageClient(StorageClient)` using `azure-storage-blob`
- `GcpStorageClient(StorageClient)` using `google-cloud-storage`

This allows you to swap clouds by configuration rather than rewriting the ETL core.

---

## 3. Diagram

The `docs/Architecture.png` file shows:

- ETL script in the center.
- Arrows to three buckets/containers (AWS, Azure, GCP).
- Zone folders inside each storage target.

---

## 4. Operations

- Logging: simple stdout or cloud-native logging if run in a scheduled job.
- Scheduling: could be run via cron, AWS Lambda + EventBridge, Azure Functions Timer, or GCP Cloud Scheduler + Cloud Run.

---

## 5. Future Enhancements

- Schema validation and automatic schema registration.
- Converting processed outputs to Parquet and registering tables in a metastore.
- Adding a small dashboard showing ingestion stats.
