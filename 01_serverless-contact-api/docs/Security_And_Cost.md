# 🔐 Security & Cost – Multi-Cloud Serverless Contact API

This document summarizes key **security** and **cost** considerations for the Contact API.

---

## 1. Security

- **Least Privilege:**  
  - AWS: Lambda role limited to the specific DynamoDB table or S3 bucket.  
  - Azure: Managed identity with scoped access to Table Storage / Cosmos DB.  
  - GCP: Service account with only required Firestore / Storage roles.

- **Network Security (Optional Enhancements):**  
  - Private endpoints / VNet integration.  
  - API gateways configured with IP allowlists, throttling, and basic WAF rules.

- **Secrets Management:**  
  - Prefer cloud-native secret managers instead of hard-coding keys.

---

## 2. Cost

- Serverless execution keeps costs low for low-to-medium traffic.
- Storage uses pay-as-you-go models (NoSQL / object storage).
- Cost levers:
  - Function memory and timeout
  - Storage class (Standard vs Infrequent Access / Archive)
  - API Gateway pricing tier / APIM tier

Documenting these shows that you understand how to run workloads **efficiently** in the cloud.
