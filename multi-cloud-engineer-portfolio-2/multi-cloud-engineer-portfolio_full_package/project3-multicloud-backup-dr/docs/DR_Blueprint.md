# Multi-Cloud Backup & Disaster Recovery Blueprint

This document describes a reference DR strategy where AWS is the primary cloud
and Azure / GCP are used as secondary backup targets.

## 1. Business Context

- Primary workloads run in AWS.
- The business requires:
  - **RPO ≤ 15 minutes** for critical transactional data.
  - **RTO ≤ 1 hour** for core APIs.

## 2. RPO / RTO Matrix

| System / Component        | RPO        | RTO        | Notes                            |
|---------------------------|-----------:|-----------:|----------------------------------|
| Customer DB (PostgreSQL)  | 15 minutes | 60 minutes | AWS RDS → snapshots → Azure/GCP |
| Object Storage (S3)       | 60 minutes | 4 hours    | Versioned S3, replicated nightly |
| Logs / Analytics          | 24 hours   | 48 hours   | Recomputed from raw events       |

## 3. High-Level Architecture

- **Primary (AWS):**
  - RDS for PostgreSQL
  - S3 for object storage
  - Lambda / ECS for compute

- **Secondary (Azure / GCP):**
  - Azure Blob Storage or GCS for backups
  - Optional warm-standby PostgreSQL instances

## 4. DR Runbook (Simplified)

1. Detect incident and declare DR event.
2. Restore latest DB snapshot into Azure or GCP.
3. Restore required objects into the secondary cloud.
4. Switch DNS to point traffic to the secondary region/cloud.
5. Operate in DR mode and monitor.
6. Plan a controlled failback to AWS when stable.

## 5. Portfolio Notes

This blueprint demonstrates understanding of multi-cloud DR patterns,
RPO/RTO tradeoffs, and step-by-step runbook thinking.
