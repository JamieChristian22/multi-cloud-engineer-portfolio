# 🌐 # Multi-Cloud Engineer Portfolio (AWS • Azure • GCP)

Job-ready, end-to-end projects that demonstrate **design + build + automate + deploy** across AWS, Azure, and Google Cloud — including **serverless**, **data engineering**, **backup/DR**, and **Professional Services-style delivery** (Terraform, CI/CD, containers, migrations, observability, security, cost optimization).

---

## Quick Navigation
- [Projects](#projects)
- [Tech Stack](#tech-stack)
- [How to Explore](#how-to-explore)
- [Contact](#contact)

---

## Projects

### ✅ Professional Services Delivery — Terraform + CI/CD + Containers + Logging + Security + Cost + Migrations

These projects are structured like real **customer-facing Professional Services** engagements and include complete artifacts (no placeholders): runbooks, validation steps, rollback plans, operational checklists, and CI/CD pipelines.

| # | Project | Cloud | What you’ll see |
|---|--------|-------|-----------------|
| 4 | **AWS Professional Services Delivery** | AWS | Terraform modules + dev/prod envs, GitHub Actions (Terraform CI + Docker→ECR), containerized app, **ECS Fargate + ALB**, CloudWatch logs/runbook, **AWS DMS migration pack**, security + cost toolkit |
| 5 | **GCP Professional Services Delivery** | GCP | Terraform + **Cloud Run**, Artifact Registry, GitHub Actions (Terraform CI + Docker→Artifact Registry), Cloud Logging/Monitoring runbook, **GCP DMS migration pack**, security + cost toolkit |
| 6 | **Azure Professional Services Delivery** | Azure | Terraform + **Container Apps**, ACR, Log Analytics + KQL, GitHub Actions (Terraform CI + Docker→ACR), runbook, **Azure DMS migration pack**, security + cost toolkit |

**Folders**
- `multi-cloud-engineer-portfolio/project4-aws-professional-services/`
- `multi-cloud-engineer-portfolio/project5-gcp-professional-services/`
- `multi-cloud-engineer-portfolio/project6-azure-professional-services/`

---

### 1️⃣ Multi-Cloud Serverless Contact API (AWS + Azure + GCP)

A functional REST API deployed on three clouds using native serverless compute:

- **AWS:** API Gateway → Lambda  
- **Azure:** Azure Functions HTTP Trigger  
- **GCP:** Cloud Functions (2nd Gen)

Endpoints:
- `GET /contacts`
- `POST /contacts`
- `GET /health`

**Skills:** serverless development, cloud APIs, identity, logging, JSON handling, portability.

Folder: `project1-multicloud-serverless-api/`

---

### 2️⃣ Multi-Cloud Data Lake & Analytics ETL Pipeline

A Python ingestion workflow that uploads normalized CSV data into:
- **AWS S3**
- **Azure Data Lake Storage Gen2**
- **Google Cloud Storage**

Switch cloud targets using environment configuration.

**Skills:** data engineering, object storage, cloud SDKs (boto3 / azure-storage-blob / google-cloud-storage), ingestion patterns, analytics architecture.

Folder: `project2-multicloud-data-lake-analytics/`

---

### 3️⃣ Multi-Cloud Backup & Disaster Recovery Blueprint

Enterprise-style architecture + runbook for:
- **AWS → Azure** warm standby failover
- **AWS → GCP** cold backup + archival
- RPO/RTO matrix
- Region outage playbook + recovery workflow

**Skills:** HA/DR strategy, backup planning, resilience engineering, architecture documentation.

Folder: `project3-multicloud-backup-dr/`

---

## Tech Stack

### Cloud Providers
- Amazon Web Services (AWS)
- Microsoft Azure
- Google Cloud Platform (GCP)

### Core Tools & Patterns
- **Terraform** (modules, environments, repeatable delivery)
- **CI/CD** (GitHub Actions)
- **Containers** (Docker; ECS Fargate / Cloud Run / Container Apps)
- **Logging/Observability** (CloudWatch / Cloud Logging / Log Analytics + runbooks)
- **Migrations** (AWS DMS / GCP DMS / Azure DMS runbooks)
- **Security** (least privilege, network boundary controls, audit readiness)
- **Cost Optimization** (right-sizing, retention policies, waste elimination, tagging)

### Languages
- Python
- JavaScript (Node.js service for container demos)

---

## How to Explore

Each project includes:
- clear README
- architecture + operational documentation
- code where applicable
- deployment/run steps
- troubleshooting/runbooks where applicable

Start with:
- **Project 4/5/6** if you’re hiring for **Cloud Engineer / DevOps / Professional Services**
- **Project 1–3** if you want **serverless + data + DR architecture breadth**

---

## Contact

**Jamie Christian II**  
LinkedIn: https://linkedin.com/in/jamiechristiananalytics  
GitHub: https://github.com/JamieChristian22  
Email: jamiechristian331@gmail.com

---

## ⭐ Support
If you find this helpful, please star the repo — it helps others discover the work.
