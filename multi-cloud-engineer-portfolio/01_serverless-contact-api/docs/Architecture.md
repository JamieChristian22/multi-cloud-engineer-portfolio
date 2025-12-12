# 🏗 Architecture – Multi-Cloud Serverless Contact API

This document explains how the Contact API is implemented across AWS, Azure, and GCP while preserving a consistent
**logical architecture** and **API contract**.

---

## 1. Logical View

1. Client sends HTTP request to `/contacts` endpoints.
2. Cloud API gateway or HTTP trigger receives the request.
3. Serverless function executes business logic:
   - validate payload
   - read/write contact record
4. Storage layer persists data.
5. Logs and metrics are captured.

---

## 2. Per-Cloud Mapping

### 2.1 AWS

- API Layer: API Gateway (HTTP or REST)
- Compute: AWS Lambda (Python runtime)
- Storage: DynamoDB table `contacts_{stage}` (or S3 bucket prefix)
- Logging: CloudWatch Logs
- IAM: execution role granting read/write to the contact table only

### 2.2 Azure

- API Layer: Azure Functions HTTP trigger (optionally behind API Management)
- Compute: Consumption plan Function App
- Storage: Azure Table Storage or Cosmos DB Table API
- Logging: Azure Monitor / Application Insights
- Identity: Managed identity for storage access (preferred)

### 2.3 GCP

- API Layer: Cloud Functions HTTP trigger (optionally behind API Gateway)
- Compute: Cloud Functions (2nd gen recommended)
- Storage: Firestore (document DB) or Cloud Storage JSON blobs
- Logging: Cloud Logging
- Security: Service account with minimal roles (e.g., Firestore User / Storage Object Admin scoped)

---

## 3. Error Handling & Parity

To keep behavior consistent:

- Validation failure → **400 Bad Request**
- Missing contact → **404 Not Found**
- Internal error → **500 Internal Server Error**
- Optional: correlation IDs included via response headers.

---

## 4. Environments

Use a `STAGE` variable such as `dev`, `test`, `prod`:

- Resource naming: `contacts_dev`, `contacts_prod`
- Separate accounts/subscriptions/projects for stricter isolation.

---

## 5. Diagram

The `Architecture.png` file illustrates:

- One client box at the top.
- Three columns: AWS, Azure, GCP.
- For each column:
  - Entry: API Gateway / Function URL
  - Lambda / Azure Function / Cloud Function
  - Data store (DynamoDB, Table Storage, Firestore)
  - Logs

---

## 6. Future Enhancements

- Add Authentication / Authorization:
  - Cognito, Azure AD, or Firebase/Auth0.
- Add rate limiting and WAF at the gateway layer.
- Add CI/CD pipelines using GitHub Actions or Azure DevOps.
