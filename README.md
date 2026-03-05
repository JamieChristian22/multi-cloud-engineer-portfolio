# Multi‑Cloud Engineer Portfolio


![AWS](https://img.shields.io/badge/AWS-Cloud-orange)
![Azure](https://img.shields.io/badge/Azure-Cloud-blue)
![Google Cloud](https://img.shields.io/badge/GCP-Cloud-red)
![Terraform](https://img.shields.io/badge/IaC-Terraform-purple)
![Kubernetes](https://img.shields.io/badge/Platform-Kubernetes-green)
![Docker](https://img.shields.io/badge/Containers-Docker-blue)
![CI/CD](https://img.shields.io/badge/DevOps-CI/CD-black)
![OpenTelemetry](https://img.shields.io/badge/Observability-OpenTelemetry-yellow)

# Multi-Cloud Engineer Portfolio (AWS • Azure • GCP)

**Owner:** Jamie Christian  
**Focus:** Multi-cloud architecture, Infrastructure as Code (Terraform), Kubernetes, CI/CD, security (Zero Trust), observability, and FinOps.

This repo contains **6 fully designed, end-to-end projects**. Each project includes:
- Architecture + design rationale
- Real code (Python / Bash / YAML)
- IaC templates (Terraform where applicable)
- CI/CD workflows (GitHub Actions)
- Reproducible local demos where possible (Docker Compose / Streamlit)
- Sample datasets to produce working outputs

> **Note:** Cloud credentials are intentionally read from environment variables (best practice). No secrets are stored in this repo.

---

## Projects

1. **01_Ecommerce_Analytics_MultiCloud_Pipeline**  
   Cross-cloud analytics: Postgres → Data Quality → Unified Fact Table → BigQuery-ready export (Parquet/CSV), with optional cloud load.

2. **02_Terraform_MultiCloud_Foundation**  
   Repeatable landing zone foundations: AWS VPC, Azure VNet, GCP VPC, with compute + storage.

3. **03_Kubernetes_MultiCloud_Microservices**  
   FastAPI microservices + containerization + Kubernetes manifests that run on EKS/AKS/GKE.

4. **04_CICD_MultiCloud_Deployments**  
   GitHub Actions pipeline: tests → build → scan → publish to GHCR → deploy to Kubernetes via Kustomize.

5. **05_ZeroTrust_Security_Federation**  
   Reference implementation of cross-cloud identity + least privilege + secrets handling patterns.

6. **06_Observability_and_FinOps**  
   Prometheus/Grafana stack + cost unification (AWS CUR / Azure cost export / GCP billing export) with Streamlit dashboard.

---

## Quick Start (Local)

Most projects have a local demo. Start here:

- Project 01: run the Postgres + pipeline demo:
  ```bash
  cd 01_Ecommerce_Analytics_MultiCloud_Pipeline
  docker compose up -d
  python pipeline/run_pipeline.py
  ```

- Project 06: run the FinOps dashboard:
  ```bash
  cd 06_Observability_and_FinOps/finops_dashboard
  python -m venv .venv && source .venv/bin/activate
  pip install -r requirements.txt
  streamlit run app.py
  ```

---

## Skills Demonstrated

- Multi-cloud networking and foundations (AWS/Azure/GCP)
- IaC with Terraform modules and environments
- Kubernetes deployments and platform patterns
- CI/CD pipelines and release automation
- Zero Trust security design + IAM policy engineering
- Observability and cost analytics (FinOps)




## New (Elite) Project
7. **07_MultiCloud_AI_Inference_Platform**  
   A distributed systems project: global inference gateway + caching + autoscaling-ready deployment patterns (local runnable demo included).

