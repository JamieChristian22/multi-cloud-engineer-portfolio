# Multi-Cloud Data Lake & Analytics ETL

This project demonstrates a single Python ETL script that can load data into
a data lake on **AWS S3**, **Azure Data Lake Storage Gen2**, or
**Google Cloud Storage**, based on an environment variable.

## Features

- Reads a CSV file from local disk.
- Uploads it to:
  - `s3://<bucket>/<prefix>/...` (AWS)
  - Azure Blob container (ADLS Gen2)
  - `gs://<bucket>/<prefix>/...` (GCP)
- Uses a common function `upload_to_cloud(provider, ...)` to switch between clouds.

## Usage

```bash
cd project2-multicloud-data-lake-analytics

export CLOUD_PROVIDER=aws   # or azure / gcp

python -m src.ingest_multicloud       --file ./data/sample_customers.csv       --bucket my-portfolio-bucket       --prefix raw/customers
```

You must configure credentials for the chosen cloud in your environment
(AWS CLI, Azure connection string, or GCP service account).
