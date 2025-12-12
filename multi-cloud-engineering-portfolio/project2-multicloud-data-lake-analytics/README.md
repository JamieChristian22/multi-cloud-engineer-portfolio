# Project 2 – Multi‑Cloud Data Lake & Analytics Orchestration (AWS, Azure, GCP)

## Elevator Pitch

You implemented a **vendor‑neutral data ingestion script** that can push CSV data into
object storage on **AWS S3**, **Azure Data Lake Storage Gen2**, and **Google Cloud Storage**.

On top of that, the project describes how to:

- Query data with **Amazon Athena**, **Azure Synapse / Serverless SQL**, and **BigQuery**.
- Use **environment variables** to switch which cloud provider the ETL job writes to.
- Demonstrate a realistic multi‑cloud analytics pattern for a portfolio.

---

## Core Idea

A single Python ETL script:

- Reads a local CSV file (e.g., `sample_data/transactions.csv`).
- Normalizes column names and adds a `ingested_at` timestamp.
- Based on `TARGET_PROVIDER` env variable, uploads the file to:
  - **AWS** – S3 bucket
  - **Azure** – ADLS Gen2 container
  - **GCP** – GCS bucket

This shows that you understand:

- Object storage concepts across all three clouds.
- Data lake ingestion patterns.
- How to parameterize code to support multiple cloud SDKs.

---

## Layout

```text
project2-multicloud-data-lake-analytics/
├── README.md
├── docs
│   └── architecture.md
└── src
    └── multicloud_ingest.py
```

---

## Quick Start

### 1. Create Storage Resources

Create a bucket/container on each provider:

- **AWS S3** – `mc-data-lake-aws`
- **Azure ADLS Gen2** – account `mcdatalakeazure`, container `raw`
- **GCS** – bucket `mc-data-lake-gcp`

(Names can be different; just keep them consistent with your environment variables.)

### 2. Install Dependencies

```bash
pip install boto3 azure-storage-blob google-cloud-storage python-dotenv
```

### 3. Set Environment Variables

You can use a `.env` file or export directly.

**Common**

- `TARGET_PROVIDER` – one of: `aws`, `azure`, `gcp`
- `INPUT_FILE` – e.g., `./transactions.csv`

**AWS**

- `AWS_REGION`
- `AWS_S3_BUCKET`

**Azure**

- `AZURE_STORAGE_ACCOUNT_NAME`
- `AZURE_STORAGE_ACCOUNT_KEY`
- `AZURE_CONTAINER_NAME`

**GCP**

- `GOOGLE_APPLICATION_CREDENTIALS` (path to service account JSON)
- `GCP_BUCKET`

### 4. Run

```bash
python src/multicloud_ingest.py
```

The script:

1. Loads the CSV.
2. Cleans column names.
3. Adds `ingested_at`.
4. Writes a new file to your configured cloud data lake.

---

## Interview Talking Points

- Explain how **object storage** is conceptually similar across clouds (buckets/containers).
- Discuss **idempotent ingestion**: running the job multiple times with timestamps.
- Describe how you would **scale this up**:
  - Schedule with Azure Data Factory, AWS Step Functions, or Cloud Composer.
  - Replace CSV with streaming ingestion using Kinesis/Event Hubs/Pub/Sub.
- Shows comfort with **SDKs**, **authentication**, and **environment‑driven configuration** across AWS, Azure, and GCP.

See `docs/architecture.md` for more detailed design notes.
