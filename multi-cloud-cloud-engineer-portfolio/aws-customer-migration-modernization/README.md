# AWS Customer Migration & Modernization (Terraform + ECS Fargate + RDS + CloudWatch)

A **no-placeholder**, end-to-end Cloud Engineer delivery package aligned to Mission Cloud–style Professional Services work:
- Reusable **Terraform IaC** modules
- **CI pipelines** for `terraform plan` / `apply`
- Containerized web app deployed to **ECS Fargate** behind an ALB
- **RDS PostgreSQL** with KMS encryption, backups, and least-privilege access
- **Centralized logging** via CloudWatch Logs + metrics + alarms
- **Cost optimization**: autoscaling + right-sizing guidance + lifecycle policies
- **Security hardening**: IAM boundaries, SG minimization, encryption, and audit-ready runbook
- **Migration playbooks**: CloudEndure (AWS Application Migration Service) + AWS DMS

> Built as a portfolio artifact: the repo is structured like a **client deliverable** with a clear “requirements → design → implementation → operations” flow.

---

## 1) Customer Scenario (Realistic Consulting Context)

**Client:** Mid-market SaaS provider (multi-tenant web app)  
**Goal:** Migrate a legacy VM-based stack to AWS and modernize deployment for reliability, security, and cost efficiency.

**Workload:**
- Web/API tier (containerized)
- PostgreSQL database
- Public traffic via HTTPS load balancer
- Central logging and alerting
- Dev environment first, then can be promoted to staging/prod via the same modules

**Non-functional requirements:**
- Highly available across 2 AZs
- Encryption at rest and in transit
- Least privilege IAM
- Repeatable deployments via Terraform + CI
- Audit-ready documentation and runbooks

---

## 2) Architecture Overview

### High-level (runtime)

```text
Internet
  |
  v
[ALB] --HTTPS--> [ECS Fargate Service] ---> [RDS PostgreSQL]
  |
  +--> [CloudWatch Logs / Metrics / Alarms]
```

### Terraform module layout (re-usable)

- `terraform/modules/vpc` — VPC, public/private subnets, IGW, NAT, route tables
- `terraform/modules/ecs_fargate` — ECS cluster/service/task, ALB, target group, listener, autoscaling
- `terraform/modules/rds_postgres` — RDS, subnet group, parameter group, encryption, backups
- `terraform/modules/iam` — task execution role, app role, least-privilege policies
- `terraform/modules/observability` — CloudWatch log groups, metric filters, alarms, dashboards

---

## 3) What’s Included

| Area | Folder | What you get |
|---|---|---|
| Terraform IaC | `terraform/` | Modules + dev environment with working composition |
| Containerized app | `app/` | Flask API + Dockerfile + health endpoint |
| CI/CD | `.github/workflows/` | Terraform plan/apply + image build/push workflow |
| Ops runbook | `docs/runbook/` | How to operate, troubleshoot, and escalate |
| Migration playbooks | `docs/migration/` | CloudEndure/MGN + AWS DMS migration steps |
| Security | `docs/security/` | Controls checklist + remediation examples |
| Cost | `docs/cost/` | cost review + scaling strategy |
| Evidence | `evidence/` | sample outputs, diagrams, and implementation notes |

---

## 4) Quick Start (Dev Environment)

> This repo is designed to be run by you in your AWS account. It uses **Terraform backend in S3 + DynamoDB lock** (recommended).

### Prereqs
- AWS account + permissions to create VPC/ECS/RDS/IAM/ALB/CloudWatch resources
- Terraform >= 1.5
- Docker
- An ECR repository (created by Terraform in this repo)

### Steps (local)

```bash
cd terraform/envs/dev
terraform init
terraform plan
terraform apply
```

After apply:
- ECS service will run the container and expose it via ALB DNS name output.
- CloudWatch log groups will contain app logs.

To destroy:
```bash
terraform destroy
```

---

## 5) CI/CD (GitHub Actions)

This repo includes workflows that:
- Run `terraform fmt` + `validate` + `plan` (on PRs)
- Run `terraform apply` (on merge to `main`)
- Build and push Docker image to ECR, then force ECS new deployment

See: `.github/workflows/`

---

## 6) How This Maps to the Job Requirements

This single package demonstrates:
- Terraform-based AWS deployments (**required**)
- CI pipelines for infra + containers (**required**)
- ECS/Fargate modernized architecture (**explicit in job**)
- Centralized logging using CloudWatch Logs (**explicit in job**)
- Cost saving via autoscaling and right-sizing guidance (**explicit in job**)
- Security gap remediation and strong controls (**explicit in job**)
- Migration playbooks using MGN/CloudEndure + AWS DMS (**explicit in job**)

---

## 7) Deliverables Index

- **Implementation**: `terraform/`, `app/`, `.github/workflows/`
- **Design**: `docs/design/architecture.md`
- **Runbook**: `docs/runbook/runbook.md`
- **Migration**: `docs/migration/mgn_cloudendure.md`, `docs/migration/aws_dms.md`
- **Security**: `docs/security/security_controls.md`
- **Cost**: `docs/cost/cost_optimization.md`
- **Testing**: `docs/testing/verification_plan.md`

---

## Contact
Jamie Christian  
Email: jamiechristian331@gmail.com  
LinkedIn: https://linkedin.com/in/jamiechristiananalytics  
GitHub: https://github.com/JamieChristian22
