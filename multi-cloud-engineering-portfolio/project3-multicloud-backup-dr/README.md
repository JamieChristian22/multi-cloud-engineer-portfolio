# Project 3 – Multi‑Cloud Backup & Disaster Recovery Blueprint (AWS, Azure, GCP)

## Elevator Pitch

You designed and documented a **multi‑cloud backup & disaster recovery (DR) strategy**:

- **Primary workload on AWS** (example: EC2 + RDS).
- **Warm backup on Azure** (VM + Azure Database).
- **Cold backup archive on GCP** (Cloud Storage).

This project is **documentation‑heavy on purpose** – hiring managers love seeing
that you understand **RPO/RTO, backup policies, regions, and failover steps**.

---

## What This Project Includes

- Clear **DR architecture** and data‑flow diagrams (described textually so they are easy to recreate).
- A realistic **runbook** for how to fail over from AWS → Azure or GCP.
- A **backup policy** matrix that defines:
  - RPO (Recovery Point Objective)
  - RTO (Recovery Time Objective)
  - Which data is backed up where and how often.

---

## Layout

```text
project3-multicloud-backup-dr/
├── README.md
└── docs
    ├── architecture.md
    ├── backup_policy_matrix.md
    └── dr_runbook.md
```

You can copy this entire folder as its own GitHub repository called:

> `multi-cloud-backup-dr-blueprint`
