# 🌐 Multi-Cloud Engineer Portfolio

**Repository:** `multi-cloud-engineer-portfolio`  
**Author:** Jamie Christian II (`@JamieChristian22`)  
**Focus:** AWS • Azure • Google Cloud • Terraform • Security • Data & Analytics

---

## 📌 Overview

This portfolio showcases hands-on skills as a **Multi-Cloud Engineer**, designing and implementing **production-style architectures** across **AWS, Azure, and Google Cloud Platform (GCP)**.

It highlights:

- **Cloud architecture designs** (reference architectures, diagrams, and design docs)
- **Infrastructure as Code (IaC)** with **Terraform/HCL**
- **Secure networking & IAM** across multiple clouds
- **Monitoring, logging, and incident response** aligned with a **cybersecurity** background
- **Data & analytics architectures** aligned with **data engineering** and **data architecture** training

The goal: show how I think, design, and build end-to-end cloud solutions that are **scalable, secure, and cost-aware**.

---

## 🧱 Tech Stack & Skills

**Cloud Providers**
- ☁️ AWS (VPC, EC2, S3, RDS, IAM, CloudFront, CloudTrail, CloudWatch, Route 53, etc.)
- ☁️ Microsoft Azure (VNet, VM, Storage, Key Vault, Monitor, Backup, App Services, etc.)
- ☁️ Google Cloud Platform (VPC, GCE, GCS, Cloud SQL, BigQuery, Cloud Logging, Cloud Monitoring)

**Core Skills**
- 🧩 **Multi-Cloud Architecture Design**
- 🏗 **Infrastructure as Code (Terraform/HCL)**
- 🔒 **Security, IAM, and Zero Trust Concepts**
- 🛰 **Networking & Hybrid Connectivity**
- 📊 **Data Architecture & Analytics Platforms**
- 🚨 **Monitoring, Logging & Incident Response**
- 🔁 **Automation, CI/CD & Git-based workflows**

**Related Certifications (selected)**
- CompTIA **CySA+ (CS0-003)**
- **Google Cybersecurity** Professional Certificate
- **IBM Data Engineering** & **IBM Data Architecture**
- **Data Architect Capstone** (SkillUp) & **Data Engineering Capstone** (IBM)
- **AWS Cloud Practitioner Essentials**, **Architecting Solutions on AWS**, **Building Data Lakes on AWS**
- **Azure Fundamentals** & **Secure & Scalable Cloud Infrastructure with Microsoft Azure**
- **Google Cloud Fundamentals/Core Infrastructure**, **Digital Leader**, **GKE Foundations**

---

## 🗂 Repository Structure

```bash
multi-cloud-engineer-portfolio/
├── multi-cloud-engineer-portfolio/
│   ├── 01-core-foundations/
│   │   ├── aws-basics/
│   │   ├── azure-basics/
│   │   ├── gcp-basics/
│   │   └── shared-design-principles.md
│   ├── 02-networking-and-connectivity/
│   ├── 03-iam-and-security/
│   ├── 04-infra-as-code-terraform/
│   │   ├── modules/
│   │   │   └── network/
│   │   └── examples/
│   │       └── aws-landing-zone/
│   ├── 05-data-and-analytics/
│   ├── 06-observability/
│   ├── 07-scenarios-and-case-studies/
│   └── docs/
│       ├── architecture-diagrams/
│       ├── decision-records/
│       └── readme-assets/
├── .gitignore
├── LICENSE
└── README.md
```

---

## 🚀 Featured Project – AWS Landing Zone (Example)

The first concrete example in this portfolio is an **AWS Landing Zone** implemented with Terraform.

**Highlights:**
- 1 VPC with configurable CIDR
- Public and private subnets across multiple AZs
- Internet gateway and public route table
- Tagging strategy for cost allocation and ownership

**Where to look:**
- Module: `multi-cloud-engineer-portfolio/04-infra-as-code-terraform/modules/network/`
- Example: `multi-cloud-engineer-portfolio/04-infra-as-code-terraform/examples/aws-landing-zone/`
- ADR: `multi-cloud-engineer-portfolio/docs/decision-records/ADR-0001-landing-zone-architecture.md`

---

## 🧪 How to Use the Terraform Example

```bash
cd multi-cloud-engineer-portfolio/04-infra-as-code-terraform/examples/aws-landing-zone

terraform init
terraform plan       -var="name=jamie-landing-zone"       -var="region=us-east-1"

# Review the plan carefully before applying:
# terraform apply
```

> ⚠️ **Note:** Use a non-production AWS account or sandbox environment. This is for learning and portfolio purposes.

---

## 🎯 Target Roles This Portfolio Supports

This repository is designed to support applications for:

- **Multi-Cloud Engineer**
- **Cloud Solutions Architect (Associate level)**
- **Cloud / DevOps Engineer**
- **Cloud Security Engineer**
- **Data & Cloud Architect (entry / mid)**
- **Systems Engineer with Cloud Focus**

---

## 📈 Roadmap

- [x] Add initial **Terraform network module** and AWS landing zone example  
- [x] Add first **architecture decision record (ADR)**  
- [ ] Add Azure and GCP landing zone examples  
- [ ] Add **multi-cloud data lake** reference architecture  
- [ ] Add **observability dashboards & alerting examples**  
- [ ] Add **end-to-end case studies** for SaaS, DR, FinServ, and Healthcare  

---

## 📬 Contact

- **GitHub:** [@JamieChristian22](https://github.com/JamieChristian22)
- **LinkedIn:** *(add link here)*
- **Portfolio Hub:** *(link to main portfolio repo when ready)*

If you’re a recruiter or hiring manager and want a guided walkthrough of this portfolio or specific projects, feel free to reach out.

---

_⭐ If you find this repo interesting, consider starring it to follow future updates._
