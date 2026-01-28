# 🌐 Multi-Cloud Engineer Portfolio – AWS · Azure · GCP

**Author:** Jamie Christian II  
**Target Roles:** Cloud Engineer · Multi-Cloud Engineer · Cloud Architect · DevOps / Platform Engineer

This portfolio showcases **job-ready multi-cloud projects** deployed or architected across **AWS, Azure, and Google Cloud Platform**.
The focus is on **real architectures**, not toy demos: serverless APIs, data lake ETL, and a production-style
backup & disaster recovery blueprint.

---

## 🔧 Multi-Cloud Skill Summary

| Area                  | Skills & Tools                                                                                 |
|-----------------------|------------------------------------------------------------------------------------------------|
| Cloud Providers       | AWS · Microsoft Azure · Google Cloud Platform                                                  |
| Compute & Serverless  | AWS Lambda · Azure Functions · GCP Cloud Functions                                             |
| Networking & APIs     | API Gateway · Azure API Management · GCP API Gateway · REST/JSON                               |
| Storage & Data        | S3 · Azure Blob / ADLS Gen2 · GCP Cloud Storage · Data Lakes · ETL Pipelines                   |
| Identity & Security   | IAM · RBAC · Service Principals · Service Accounts · Least Privilege · Secrets Management      |
| Resiliency & DR       | Backups · Cross-Region / Cross-Cloud DR · RPO/RTO Design                                      |
| IaC & Automation      | Terraform (buckets, functions, IAM) · Environment configuration via `.env` / config files     |
| Observability         | CloudWatch Logs · Azure Monitor / App Insights · Cloud Logging                                 |
| Languages             | Python (boto3, azure-storage-blob, google-cloud-storage)                                       |

---

## 📁 Project Index

### 1. Multi-Cloud Serverless Contact API (AWS · Azure · GCP)

**Folder:** `01_serverless-contact-api/`  

A **Contact directory API** implemented natively on AWS Lambda, Azure Functions, and GCP Cloud Functions with a
**shared REST contract**. Demonstrates how to keep client behavior identical while the infrastructure is cloud-specific.

- Endpoints: `POST /contacts`, `GET /contacts/{id}`, `DELETE /contacts/{id}`, `GET /contacts`
- Storage: DynamoDB / Azure Table / Firestore (or equivalent)
- Docs: Architecture, Deployment, Testing, Security & Cost

👉 See: `01_serverless-contact-api/README.md`

---

### 2. Multi-Cloud Data Lake & ETL Pipeline (AWS · Azure · GCP)

**Folder:** `02_multicloud-datalake-etl/`  

A **config-driven ETL pipeline** that loads CSV data into **S3**, **ADLS Gen2**, or **GCS** just by switching configuration.
Implements the classic **Landing → Raw → Processed** data lake zones and uses a small abstraction layer to swap SDKs.

👉 See: `02_multicloud-datalake-etl/README.md`

---

### 3. Multi-Cloud Backup & Disaster Recovery Blueprint

**Folder:** `03_disaster-recovery-blueprint/`  

A realistic **multi-cloud DR strategy** where:

- **AWS** is the primary production environment
- **Azure** hosts a **warm standby**
- **GCP** stores **cold backups** for long-term retention

Includes an RPO/RTO matrix, DR runbook, architecture diagram, and risk log you can speak to in interviews.

👉 See: `03_disaster-recovery-blueprint/README.md`

---

## 🏗 Documentation Pattern

Each project follows the same documentation structure:

- `README.md` – high-level overview, use case, and key decisions
- `docs/Architecture.md` – architecture diagrams and design rationale
- `docs/Deployment.md` – how to deploy (where applicable)
- `docs/Testing*.md` – how to validate behavior and parity
- `docs/RPO_RTO_Matrix.*` / `Risk_*.md` – for DR-specific planning

This makes the repo easy for **recruiters, hiring managers, and engineers** to navigate quickly.

---

## 🚀 Using This Portfolio in Interviews

Use this repo as the **anchor** for cloud-focused conversations:

- “Tell me about an API you built” → Serverless Contact API
- “Tell me about a data pipeline / data lake you designed” → Multi-Cloud ETL
- “Tell me about fault tolerance or disaster recovery” → DR Blueprint

Link this repo on your **resume**, **LinkedIn**, and application forms as your **Cloud / Multi-Cloud Portfolio**.
