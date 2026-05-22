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

```text
Client Request
      ↓
 API Gateway
      ↓
 AWS Lambda
      ↓
 JSON Response
```

---

# 🎯 Project Objectives

✅ Build a fully functional serverless REST API  
✅ Deploy and test AWS Lambda functions  
✅ Configure API Gateway integrations  
✅ Monitor cloud resources using CloudWatch  
✅ Implement IAM role-based permissions  
✅ Practice real-world cloud troubleshooting workflows  
✅ Create resume-ready cloud engineering experience  

---

# ☁️ AWS Services Used

## ⚡ AWS Lambda

Used to host serverless Python application logic without provisioning servers.

### Function Name

```text
insurance-quote-api
```

### Runtime

```text
Python 3.12
```

---

## 🌐 API Gateway

Configured HTTP API routes to invoke Lambda functions through secure HTTPS endpoints.

### Route

```text
/insurance-quote-api
```

### Method

```text
ANY
```

---

## 📊 CloudWatch

Used for:

- 📈 Invocation monitoring
- ⏱️ Duration tracking
- ❌ Error monitoring
- 🚦 Throttle tracking
- 🔍 Operational visibility

---

## 🔐 IAM

Configured secure execution roles and permissions for Lambda and API Gateway integrations.

---

# 💻 Lambda Function Code

```python
import json

def lambda_handler(event, context):

    response = {
        "message": "Insurance Quote API Running Successfully",
        "status": "success",
        "service": "AWS Lambda"
    }

    return {
        'statusCode': 200,
        'body': json.dumps(response)
    }
```

---

# 🔗 API Endpoint

## 🌍 Live Endpoint

```text
https://0jfzyk2nog.execute-api.us-east-2.amazonaws.com/prod/insurance-quote-api
```

## 🧪 Example Request

```text
https://0jfzyk2nog.execute-api.us-east-2.amazonaws.com/prod/insurance-quote-api?age=35&coverage=500000
```

---

# 📦 Example API Response

```json
{
  "message": "Insurance Quote API Running Successfully",
  "status": "success",
  "service": "AWS Lambda"
}
```

---

# 📈 Monitoring & Observability

CloudWatch metrics monitored:

- 📊 Invocations
- ⏱️ Duration
- ⚙️ Concurrent Executions
- ❌ Errors
- 🚦 Throttles

This project demonstrates practical cloud monitoring and operational visibility used in real production serverless environments.

---

# 🔒 Security & Cost Optimization

## 🛡️ Security Measures

- IAM least-privilege execution roles
- Managed Lambda execution policies
- HTTPS-secured API endpoint
- Cloud-native security architecture

## 💰 Cost Optimization

- Serverless pay-per-request architecture
- Free-tier conscious deployment strategy
- Minimal compute utilization
- CloudWatch monitoring for resource tracking

---

# 🧠 Skills Demonstrated

- ☁️ AWS Cloud Engineering
- ⚡ Serverless Computing
- 🌐 REST API Deployment
- 🔗 API Gateway Configuration
- 📊 Cloud Monitoring
- 🔐 IAM Security Configuration
- 🐍 Python Cloud Development
- 🛠️ Cloud Troubleshooting
- 🚀 Infrastructure Deployment
- 📈 Cloud Operations

---

# 📸 Screenshots

## Included Screenshots

- 📷 Lambda Function Deployment
- 📷 API Gateway Configuration
- 📷 Successful API Test
- 📷 CloudWatch Metrics Dashboard
- 📷 IAM Role Configuration
- 📷 API Deployment Stages

---

# 📄 Resume Bullet Example

> Designed and deployed a serverless AWS application using Lambda, API Gateway, IAM, and CloudWatch, implementing a live REST API with monitoring, security controls, and cloud-native architecture.

---

# 🔮 Future Improvements

- 🗄️ DynamoDB integration
- 🏗️ Terraform Infrastructure-as-Code
- 🔄 CI/CD pipeline integration
- 🔑 JWT authentication
- 🚦 API rate limiting
- 🌍 CloudFront integration
- 🌐 Custom domain configuration
- 🧪 Multi-environment deployments

---

# 👨‍💻 Author

## Jamie Christian

🔗 GitHub:  
https://github.com/JamieChristian22

---

# 🌎 Portfolio Repository

🔗 Multi-Cloud Engineering Portfolio:  
https://github.com/JamieChristian22/multi-cloud-engineer-portfolio
