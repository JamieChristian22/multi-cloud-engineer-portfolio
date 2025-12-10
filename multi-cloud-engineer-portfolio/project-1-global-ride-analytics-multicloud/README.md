# 🚕 Global Ride Analytics – Multi-Cloud Data Lakehouse

**Author:** Jamie Christian  
**Clouds:** AWS ▪ Azure ▪ GCP  
**Patterns:** Data Lakehouse ▪ ETL ▪ Cross-Cloud Replication ▪ BI Analytics

---

## 1. Real-World Scenario

A global mobility / taxi company operates in multiple regions.  
Each region adopted a different primary cloud:

- North America → **AWS**
- EMEA → **Azure**
- APAC → **GCP**

Leadership wants **one analytics strategy** and consistent KPIs:

- Average trip distance and duration by zone
- Revenue & utilization per hour/day/week
- Driver & fleet performance / profitability
- Surge vs non-surge behavior

**Problem:** Data is siloed by region + cloud.  
**Goal:** Build a **multi-cloud data lakehouse** that:

- Uses **AWS** as the **system of record** for raw trip data (public TLC dataset).
- Replicates curated data into **Azure** and **GCP** for local/regional analytics.
- Keeps schemas and metrics consistent across clouds.

---

## 2. Dataset

I design this project around the public **NYC Taxi & Limousine Commission (TLC) Trip Record Data**, which typically includes:

- Pickup / dropoff timestamps
- Pickup / dropoff locations (zone IDs)
- Trip distance (miles)
- Fare, tip, tolls, total amount
- Passenger count
- Payment type (cash, card, etc.)

> In a real deployment, the TLC data (or similar mobility data) would be staged in S3 as raw CSV/Parquet.  
> In this portfolio, the focus is on **architecture, data modeling, and pipelines**, not shipping the actual dataset.

---

## 3. High-Level Architecture

📁 See diagram:  
`diagrams/architecture-global-ride-analytics.png`

**Flow Overview:**

1. **AWS – System of Record**
   - Raw files land in **Amazon S3** (e.g., `s3://global-ride/raw/tlc/`).
   - **AWS Glue** crawlers infer schema & create tables in the **Glue Data Catalog**.
   - **Glue ETL (PySpark)** cleans data and writes **partitioned Parquet** into a curated zone (`s3://global-ride/curated/tlc/`).
   - Analysts can query via **Amazon Athena** or **Redshift Serverless**.

2. **Cross-Cloud Replication**
   - Curated data in S3 is replicated to:
     - **Azure Data Lake Storage Gen2 (ADLS)** → **Azure Synapse Analytics**.
     - **Google Cloud Storage (GCS)** → **BigQuery**.
   - Replication can be done via:
     - **AWS DMS**, or
     - **Airflow DAGs** pulling from S3 and pushing to ADLS & GCS.

3. **Analytics & BI**
   - **Azure Synapse** powers **Power BI** dashboards for finance & operations.
   - **BigQuery** powers **Looker Studio** dashboards for product / DS teams.
   - All three clouds share a **common semantic model** (same KPIs, dimensions).

4. **Security & Governance**
   - IAM roles / service principals control access.
   - Data is encrypted at rest (KMS / Key Vault / Cloud KMS) and in transit.
   - Logging via **CloudWatch**, **Azure Monitor**, **Cloud Logging**.

---

## 4. Cloud Services Used

### AWS

- **S3** – Raw + curated data zones.
- **Glue** – Crawlers + PySpark ETL (`pipelines/glue_job_tlc_cleaning.py`).
- **Athena / Redshift** – Ad-hoc queries, reporting.
- **IAM, KMS, CloudWatch** – Security & observability.

### Azure

- **ADLS Gen2** – Landing / curated zones.
- **Synapse Analytics** – Serverless and/or dedicated pools.
- **Azure Data Factory** – Pipelines (copy data from S3 / GCS if needed).
- **Key Vault, Monitor, Log Analytics** – Secrets & monitoring.

### GCP

- **Cloud Storage (GCS)** – Landing / curated TLC data.
- **BigQuery** – Columnar warehouse for fast analytics.
- **Cloud Composer / Dataflow** – Optional orchestration / ETL.
- **Cloud Logging, Cloud KMS, IAM** – Observability & security.

---

## 5. Repository Structure for This Project

```bash
project-1-global-ride-analytics/
│
├── README.md
├── diagrams/
│   └── architecture-global-ride-analytics.png
│
├── infrastructure/
│   └── terraform/
│       ├── aws-main.tf
│       ├── azure-main.tf
│       ├── gcp-main.tf
│       ├── variables.tf
│       └── outputs.tf
│
├── pipelines/
│   ├── airflow_dag_global_ride.py
│   └── glue_job_tlc_cleaning.py
│
└── docs/
    ├── data-dictionary.md
    ├── governance-and-security-notes.md
    └── interview-talking-points.md
