# 🚀 Deployment Guide – Multi-Cloud Serverless Contact API

This guide outlines the high-level steps to deploy the Contact API to **AWS**, **Azure**, and **GCP**.

> Adjust resource names, regions, and project IDs as needed.

---

## 1. Common Steps

1. Clone the repository:

   ```bash
   git clone https://github.com/JamieChristian22/multi-cloud-engineer-portfolio.git
   cd multi-cloud-engineer-portfolio/01_serverless-contact-api
   ```

2. (Optional) Create and activate a Python virtual environment.

3. Install dependencies if a `requirements.txt` is present:

   ```bash
   pip install -r requirements.txt
   ```

---

## 2. AWS – Lambda + API Gateway

1. Configure AWS CLI:

   ```bash
   aws configure
   ```

2. Use AWS SAM or the Serverless Framework. For example with SAM:

   ```bash
   sam build
   sam deploy --guided
   ```

3. Note the output API endpoint, e.g.:

   ```
   https://<api-id>.execute-api.<region>.amazonaws.com/Prod
   ```

4. Test with curl:

   ```bash
   curl -X GET "https://<api-id>.execute-api.<region>.amazonaws.com/Prod/contacts"
   ```

---

## 3. Azure – Azure Functions

1. Sign in:

   ```bash
   az login
   ```

2. Create a Function App (example):

   ```bash
   az functionapp create      --resource-group <RESOURCE_GROUP>      --consumption-plan-location <LOCATION>      --runtime python      --functions-version 4      --name <FUNCTION_APP_NAME>      --storage-account <STORAGE_ACCOUNT_NAME>
   ```

3. Deploy using Azure Functions Core Tools:

   ```bash
   func azure functionapp publish <FUNCTION_APP_NAME>
   ```

4. Grab the Function URL from the output or Azure Portal, then test.

---

## 4. GCP – Cloud Functions

1. Authenticate:

   ```bash
   gcloud auth login
   gcloud config set project <GCP_PROJECT_ID>
   ```

2. Deploy a function:

   ```bash
   gcloud functions deploy contacts_api      --runtime python311      --trigger-http      --allow-unauthenticated      --region=<REGION>
   ```

3. Use the given trigger URL and append `/contacts` paths where applicable.

---

## 5. Configuration & Secrets

For each environment:

- Non-sensitive config: environment variables (`STAGE`, `LOG_LEVEL`, table/bucket names).
- Secrets (if any): store in AWS Secrets Manager, Azure Key Vault, or GCP Secret Manager.

---

## 6. Validation Checklist

- Endpoints return expected status codes.
- Data is written/read from the configured storage.
- Logs appear in CloudWatch, Azure Monitor, and Cloud Logging.
