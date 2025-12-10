# 🛒 Project 3 – E‑Commerce Clickstream & Transactions (Multi‑Cloud Customer 360)

## Problem

Retail brand runs across multiple regions & clouds. You design a **multi‑cloud lakehouse + feature store** for clickstream + transaction data.

## Architecture (Summary)

See `diagrams/architecture-ecommerce-clickstream.png`.

- Events & orders land in S3 / ADLS / GCS.
- Spark/Databricks builds Delta/Iceberg tables.
- Warehouses (Redshift, Synapse, BigQuery) serve BI & ML.
- Feature store exposes RFM, engagement, and churn features.

## Files

- `diagrams/architecture-ecommerce-clickstream.png`
- `pipelines/spark_clickstream_etl.py`
- `pipelines/spark_feature_store_builder.py`
- `infrastructure/terraform/*`
- `docs/*` – datasets, design notes, interview talking points.
