# 01 — E-Commerce Analytics Multi-Cloud Pipeline

## Goal
Build a production-style analytics pipeline that:
- Extracts data from **PostgreSQL** (transactional system)
- Runs **data quality checks**
- Produces a unified **fact_orders** dataset
- Exports to **Parquet + CSV** for **cross-cloud analytics** (BigQuery-ready)
- Includes an **optional BigQuery loader** step (if credentials are present)

This is a practical multi-cloud scenario: keep the operational DB on one platform, compute transformation anywhere, and land analytics in a separate cloud.

---

## Architecture (Conceptual)

```text
PostgreSQL (OLTP)
   |
   | 1) Extract (Python)
   v
Staging DataFrames
   |
   | 2) Quality Rules (Python)
   v
Curated Fact Table (fact_orders)
   |
   | 3) Export (Parquet/CSV)
   v
Analytics Lake (object storage)
   |
   | 4) Optional: Load to BigQuery
   v
BigQuery Dataset (analytics.fact_orders)
```

---

## What’s Included

- `docker-compose.yml` to run Postgres locally
- Seed SQL with real-looking sample data (customers, products, orders, order_items)
- Pipeline code:
  - `pipeline/run_pipeline.py` — end-to-end run
  - `pipeline/quality_rules.py` — checks (nulls, ranges, referential integrity)
  - `pipeline/build_fact.py` — creates fact table
  - `pipeline/export.py` — Parquet/CSV output
  - `pipeline/load_bigquery.py` — optional loader (env-driven)

---

## Local Demo (Recommended)

### 1) Start Postgres
```bash
docker compose up -d
```

### 2) Run Pipeline
```bash
python pipeline/run_pipeline.py
```

### 3) Outputs
- `output/fact_orders.parquet`
- `output/fact_orders.csv`
- `output/data_quality_report.json`

---

## Optional: Load to BigQuery (If you have credentials)

Set environment variables:
- `GOOGLE_APPLICATION_CREDENTIALS` (path to service account JSON)
- `BQ_PROJECT_ID`
- `BQ_DATASET` (default: `analytics`)
- `BQ_TABLE` (default: `fact_orders`)

Then run:
```bash
python pipeline/load_bigquery.py
```

---

## Data Quality Rules (Examples)
- No negative `quantity` or `unit_price`
- `order_total` equals sum(order_items)
- `order_items.order_id` exists in `orders`
- `orders.customer_id` exists in `customers`

---

## Why This Is Multi-Cloud
- Demonstrates **separation of concerns**: OLTP vs analytics
- Outputs are **cloud-neutral** (Parquet/CSV)
- Optional **cloud load** step enables BigQuery without changing core pipeline logic
