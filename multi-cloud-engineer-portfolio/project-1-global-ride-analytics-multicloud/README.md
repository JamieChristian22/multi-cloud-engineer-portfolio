# 🚕 Project 1 – Global Ride Analytics (Multi‑Cloud Data Lakehouse)

## Problem

Global mobility company needs unified taxi analytics while regions use different clouds. You build a **multi‑cloud lakehouse**: AWS as system of record; Azure & GCP consume curated data.

## Dataset

Use public **NYC Taxi & Limousine Commission (TLC) trip data** hosted on AWS & other portals.

## Architecture (Summary)

See `diagrams/architecture-global-ride-analytics.png`.

- **AWS** – S3 raw/curated, Glue ETL, Athena/Redshift.
- **Replication** – DMS / Airflow jobs push curated data to Azure & GCP.
- **Azure** – ADLS + Synapse, accessed by Power BI.
- **GCP** – GCS + BigQuery, accessed by Looker Studio.
- **Security/Obs** – IAM, KMS/Key Vault/KMS, CloudWatch/Monitor/Cloud Logging.

## Files

- `diagrams/architecture-global-ride-analytics.png`
- `infrastructure/terraform/*` – AWS, Azure, GCP skeletons.
- `pipelines/airflow_dag_global_ride.py`
- `pipelines/glue_job_tlc_cleaning.py`
- `docs/*` – data dictionary, governance notes, interview talking points.
