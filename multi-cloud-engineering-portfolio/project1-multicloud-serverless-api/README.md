# Project 1 – Multi‑Cloud Serverless Contact API (AWS, Azure, GCP)

## Elevator Pitch

You built the *same* JSON Contact API on **three clouds**:

- **AWS** – API Gateway + Lambda
- **Azure** – Azure Functions + Function App + HTTP Trigger
- **GCP** – Cloud Functions (2nd gen) + HTTPS Trigger

All three implementations expose:

- `GET /contacts` – list contacts
- `POST /contacts` – create a contact (in‑memory for demo)
- `GET /health` – simple health check

This shows recruiters that you understand **serverless**, **HTTP APIs**, and how to port workloads between **AWS, Azure, and GCP**.

---

## Architecture Summary

### Common Pattern

1. **Client** (browser / Postman / backend) sends HTTP request.
2. **Cloud-native API layer** receives the request.
3. **Serverless function** executes business logic in Python.
4. Response is sent as JSON with standard HTTP status codes.

### AWS

- **Amazon API Gateway (HTTP API)** → **AWS Lambda** (`lambda_handler.py`)
- Runtime: `python3.11`
- Logging: **CloudWatch Logs**
- Config via **environment variables**:
  - `STAGE` – environment name (`dev`, `prod`)

### Azure

- **Azure Functions** (HTTP-triggered) in a **Function App**
- Runtime: `python` / v4
- **function.json** wires HTTP trigger to `main` handler.
- Deployed via **Azure Functions Core Tools** or Azure DevOps/GitHub Actions.

### GCP

- **Cloud Functions (2nd gen)** with **HTTP trigger**
- Runtime: `python311`
- Deploy via `gcloud functions deploy` with `--allow-unauthenticated`.

---

## Tech Stack

- **Language:** Python 3.11
- **Clouds:** AWS, Azure, GCP
- **API format:** JSON over HTTP
- **Tools (recommended):** Postman / curl for testing, GitHub for source control

---

## Repository Layout

```text
project1-multicloud-serverless-api/
├── README.md
├── src
│   ├── aws
│   │   └── lambda_handler.py
│   ├── azure
│   │   ├── function_app
│   │   │   ├── __init__.py
│   │   │   └── function.json
│   └── gcp
│       └── main.py
└── docs
    └── architecture.md
```

---

## How to Run – High Level

> **Note:** You can deploy any *one* cloud end‑to‑end for interviews, but having all three in your repo proves multi‑cloud skill.

### 1. AWS – API Gateway + Lambda

**Prereqs**

- AWS account
- AWS CLI configured
- Python 3.11 + zip

**Steps (minimal flow)**

1. Package function:

   ```bash
   cd src/aws
   zip function.zip lambda_handler.py
   ```

2. Create Lambda function (example):

   ```bash
   aws lambda create-function \
     --function-name mc-contact-api \
     --runtime python3.11 \
     --role arn:aws:iam::<ACCOUNT_ID>:role/<LambdaExecutionRole> \
     --handler lambda_handler.lambda_handler \
     --zip-file fileb://function.zip
   ```

3. Create an **HTTP API** in API Gateway and integrate it with the Lambda function,
   mapping:

   - `GET /contacts` → Lambda
   - `POST /contacts` → Lambda
   - `GET /health`   → Lambda

4. Test with curl or Postman (replace `<url>`):

   ```bash
   curl -X GET <url>/contacts
   curl -X POST <url>/contacts -H "Content-Type: application/json" \
        -d '{"name": "Jamie", "email": "jamie@example.com"}'
   ```

---

### 2. Azure – HTTP Trigger Function

**Prereqs**

- Azure account
- Azure Functions Core Tools
- Python 3.11

**Steps**

1. From the repo root:

   ```bash
   cd src/azure
   func start
   ```

   This runs the Functions runtime locally.

2. Deploy to Azure (example):

   ```bash
   func azure functionapp publish <YOUR_FUNCTION_APP_NAME>
   ```

3. Once deployed, copy the function URL from the portal and test:

   ```bash
   curl "<AZURE_FUNCTION_URL>/api/contacts"
   ```

---

### 3. GCP – Cloud Function (2nd gen)

**Prereqs**

- GCP project
- `gcloud` CLI
- Python 3.11

**Deploy**

From `src/gcp`:

```bash
gcloud functions deploy mc-contact-api \
  --gen2 \
  --runtime python311 \
  --region=us-central1 \
  --source=. \
  --entry-point=entry_point \
  --trigger-http \
  --allow-unauthenticated
```

Test:

```bash
curl https://<REGION>-<PROJECT_ID>.cloudfunctions.net/mc-contact-api/contacts
```

---

## Talking Points for Interviews

- Demonstrated **vendor‑neutral serverless design** – the same business logic running on three cloud providers.
- Show understanding of **API design, HTTP methods, JSON formats**, and **idempotent GET vs state‑changing POST**.
- Can discuss **trade‑offs** between AWS Lambda, Azure Functions, and Google Cloud Functions:
  - Cold starts, pricing, observability, and deployment workflows.
- Good story for **“Tell me about a time you worked in a multi‑cloud environment.”**

Read `docs/architecture.md` for diagrams and deeper technical notes.
