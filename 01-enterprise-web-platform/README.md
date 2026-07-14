# 🌍 Enterprise Web Platform

> Enterprise-grade multi-cloud web platform built across **Amazon Web Services (AWS)**, **Microsoft Azure**, and **Google Cloud Platform (GCP)** using Infrastructure as Code, enterprise networking, monitoring, and security.

<p align="center">

![AWS](https://img.shields.io/badge/AWS-Cloud-orange?style=for-the-badge\&logo=amazonaws)
![Azure](https://img.shields.io/badge/Azure-Cloud-blue?style=for-the-badge\&logo=microsoftazure)
![Google Cloud](https://img.shields.io/badge/Google%20Cloud-Platform-red?style=for-the-badge\&logo=googlecloud)
![Terraform](https://img.shields.io/badge/Terraform-IaC-623CE4?style=for-the-badge\&logo=terraform)
![Linux](https://img.shields.io/badge/Linux-Ubuntu-E95420?style=for-the-badge\&logo=ubuntu)
![Apache](https://img.shields.io/badge/Apache-Web%20Server-D22128?style=for-the-badge\&logo=apache)
![GitHub](https://img.shields.io/badge/GitHub-Version%20Control-181717?style=for-the-badge\&logo=github)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)

</p>

---

# 📖 Overview

The **Enterprise Web Platform** demonstrates how a production-style web application can be deployed consistently across multiple cloud providers while following enterprise infrastructure, networking, monitoring, and security best practices.

Rather than deploying a simple virtual machine, this project simulates the foundational infrastructure used by organizations operating in multi-cloud environments.

The objective is to demonstrate practical cloud engineering skills including:

* Multi-cloud architecture
* Enterprise networking
* Secure infrastructure deployment
* Infrastructure as Code (Terraform)
* Monitoring & observability
* Identity & Access Management
* High availability concepts
* Production-ready documentation

---

# 🎯 Project Objectives

* Deploy infrastructure in AWS, Azure, and GCP
* Build isolated cloud networks
* Deploy Linux web servers
* Configure secure firewall rules
* Enable centralized monitoring
* Practice Infrastructure as Code
* Document enterprise architecture
* Simulate production cloud environments

---

# ☁️ Cloud Platforms

## Amazon Web Services

* VPC
* Public Subnet
* Internet Gateway
* Route Tables
* Security Groups
* EC2
* Elastic IP
* CloudWatch
* IAM
* S3

---

## Microsoft Azure

* Resource Group
* Virtual Network
* Subnet
* Network Security Group
* Public IP
* Virtual Machine
* Azure Monitor
* Log Analytics
* Azure Storage

---

## Google Cloud Platform

* VPC Network
* Subnet
* Firewall Rules
* Compute Engine VM
* Cloud Monitoring
* Cloud Logging
* Cloud Storage
* IAM

---

# 🏗️ Architecture

```text
                Internet
                    │
        ┌───────────┼───────────┐
        │           │           │
        ▼           ▼           ▼

      AWS         Azure        GCP

      VPC          VNet         VPC
       │            │            │
 Public Subnet  Public Subnet Public Subnet
       │            │            │
     Linux VM    Linux VM     Linux VM
       │            │            │
 Apache/Nginx  Apache/Nginx Apache/Nginx
       │            │            │
 CloudWatch   Azure Monitor Cloud Monitoring
```

---

# 🛠 Technology Stack

## Cloud

* AWS
* Azure
* Google Cloud

## Infrastructure

* Terraform
* Linux
* Networking

## Web

* Apache HTTP Server
* Nginx
* HTML

## Security

* IAM
* Security Groups
* Network Security Groups
* Firewall Rules

## Monitoring

* CloudWatch
* Azure Monitor
* Cloud Monitoring

## Version Control

* Git
* GitHub

---

# 📁 Repository Structure

```text
01-enterprise-web-platform/

├── aws/
│   ├── terraform/
│   ├── scripts/
│   ├── screenshots/
│   └── docs/
│
├── azure/
│   ├── terraform/
│   ├── scripts/
│   ├── screenshots/
│   └── docs/
│
├── gcp/
│   ├── terraform/
│   ├── scripts/
│   ├── screenshots/
│   └── docs/
│
├── diagrams/
├── architecture/
├── images/
├── README.md
├── LICENSE
├── CHANGELOG.md
└── SECURITY.md
```

---

# 🚀 Deployment Workflow

```text
Terraform

↓

Provision Cloud Infrastructure

↓

Configure Networking

↓

Deploy Linux VM

↓

Install Apache

↓

Deploy Sample Website

↓

Configure Security

↓

Enable Monitoring

↓

Validate Deployment

↓

Document Results
```

---

# 🔒 Security Features

* Least Privilege IAM
* Private networking architecture
* Firewall restrictions
* Security Groups
* Network Security Groups
* HTTPS-ready architecture
* SSH access controls
* Logging enabled
* Monitoring enabled

---

# 📊 Monitoring

AWS

* CloudWatch Metrics
* CPU Monitoring
* Memory Monitoring
* Log Collection

Azure

* Azure Monitor
* VM Insights
* Log Analytics

Google Cloud

* Cloud Monitoring
* Operations Suite
* Cloud Logging

---

# 📸 Project Screenshots

Create a **screenshots/** folder containing images such as:

```
AWS Console

Azure Portal

Google Cloud Console

Terraform Apply

Linux Terminal

Apache Running

Monitoring Dashboard

Network Configuration

Architecture Diagram

Resource Inventory
```

---

# 📈 Skills Demonstrated

* Cloud Engineering
* Infrastructure as Code
* Enterprise Networking
* Linux Administration
* Cloud Security
* IAM
* Monitoring
* Documentation
* Troubleshooting
* Platform Engineering

---

# 🎓 Learning Outcomes

This project strengthened practical experience with:

* Multi-cloud deployment
* Cloud networking
* Linux server administration
* Infrastructure automation
* Enterprise documentation
* Secure cloud architecture
* Monitoring and observability
* Production deployment workflows

---

# 🔮 Future Enhancements

* Kubernetes deployment
* Load Balancers
* Auto Scaling
* Managed Databases
* HTTPS Certificates
* DNS Integration
* CI/CD Pipelines
* Docker containers
* WAF integration
* Secrets management

---

# 📚 Related Projects

* 🌐 02 – Network Infrastructure Platform
* 💾 03 – Storage and Data Platform
* 📈 04 – Monitoring Platform
* 🛡️ 05 – Disaster Recovery Platform

---

# 👨‍💻 Author

**Jamie Christian**

Cloud Engineer | Multi-Cloud Engineer | Platform Engineer | DevOps | Cloud Security

GitHub:
https://github.com/JamieChristian22

---

# 📄 License

This project is licensed under the MIT License.

---

## ⭐ Support

If you found this project helpful:

⭐ Star the repository

🍴 Fork the project

📝 Share feedback

🤝 Connect with me on GitHub
