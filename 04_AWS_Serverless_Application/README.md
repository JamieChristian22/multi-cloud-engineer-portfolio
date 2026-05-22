# ☁️ 04_AWS_Serverless_Application

![AWS](https://img.shields.io/badge/AWS-Cloud_Engineering-orange?style=for-the-badge&logo=amazonaws)
![Lambda](https://img.shields.io/badge/AWS_Lambda-Serverless-yellow?style=for-the-badge&logo=awslambda)
![API Gateway](https://img.shields.io/badge/API_Gateway-REST_API-red?style=for-the-badge&logo=amazonapigateway)
![CloudWatch](https://img.shields.io/badge/CloudWatch-Monitoring-blue?style=for-the-badge&logo=amazoncloudwatch)
![Python](https://img.shields.io/badge/Python-3.12-blue?style=for-the-badge&logo=python)
![Serverless](https://img.shields.io/badge/Architecture-Serverless-success?style=for-the-badge)
![IAM](https://img.shields.io/badge/IAM-Security-critical?style=for-the-badge&logo=amazonaws)
![Status](https://img.shields.io/badge/Status-Production_Ready-brightgreen?style=for-the-badge)

---

# 🚀 Project Overview

This project demonstrates the design, deployment, and monitoring of a real-world AWS serverless application using AWS Lambda, API Gateway, CloudWatch, and IAM. The application exposes a live REST API endpoint capable of handling HTTP requests through a fully managed serverless architecture.

The project was built as part of a multi-cloud engineering portfolio focused on hands-on cloud infrastructure, serverless computing, monitoring, and Infrastructure-as-Code concepts.

---

# 🏗️ Architecture

```text id="prw0z0"
Client Request
      ↓
 API Gateway
      ↓
 AWS Lambda
      ↓
 JSON Response
