# Architecture – Multi‑Cloud Serverless Contact API

## Purpose

Showcase a **portable micro‑API** implemented with **serverless** on three major public clouds:

- AWS (API Gateway + Lambda)
- Azure (Azure Functions)
- GCP (Cloud Functions)

---

## Logical Flow (All Clouds)

1. Client sends request to `/contacts` or `/health`.
2. Cloud HTTP endpoint validates the request.
3. Serverless function runs Python handler:
   - Routes based on path and method.
   - Uses an in‑memory list as a simple “database” for demo purposes.
4. Returns JSON with status code, message, and data payload.

---

## AWS Architecture

**Components**

- Amazon API Gateway (HTTP API)
- AWS Lambda function
- Amazon CloudWatch Logs

**Flow**

1. API Gateway receives `/contacts` or `/health`.
2. Requests are proxied to **Lambda**.
3. Lambda function:
   - Parses `event["httpMethod"]` and `event["path"]`.
   - Routes to `get_contacts`, `create_contact`, or `health_check`.
4. Response is returned via API Gateway to the client.

**Security**

- API can later be secured using:
  - IAM auth
  - Cognito authorizers
  - API keys with usage plans

---

## Azure Architecture

**Components**

- Azure Function App (Python)
- HTTP Trigger
- Application Insights (logging/metrics)

**Flow**

1. Incoming HTTP request hits the Function URL (e.g., `/api/contacts`).
2. **HTTP trigger** wraps the request in an `HttpRequest` object.
3. The function handler reads the method and route and runs the same Python logic.
4. Returns `HttpResponse` containing JSON.

**Notes**

- Paths are handled with query string `path` (e.g. `?path=/contacts`) for simplicity in this sample.
- Can be expanded using Azure API Management for richer routing and policies.

---

## GCP Architecture

**Components**

- Cloud Functions (2nd gen)
- HTTPS trigger
- Cloud Logging

**Flow**

1. HTTPS request hits the function URL.
2. Cloud Functions injects a `flask.Request` object into the `entry_point` handler.
3. Handler parses method + path, calls Python routing functions.
4. Returns a Flask response with JSON content and status code.

---

## Design Choices

### 1. Shared Business Logic

- All Python handlers implement **the same interface**:
  - `GET /contacts`
  - `POST /contacts`
  - `GET /health`
- Makes it easy to reason about code portability.

### 2. Stateless Functions

- Contacts are stored in a **module‑level list** for demo.
- In a real system, you would plug in:
  - DynamoDB / RDS / Aurora (AWS)
  - Cosmos DB / SQL Database (Azure)
  - Cloud SQL / Firestore (GCP)

### 3. Minimal Dependencies

- Only use Python standard library (`json`, `uuid`) for function logic.
- No external dependencies to keep deployment simple and focused.

---

## Extending the System (Future Enhancements You Can Talk About)

Even though this project is fully working as‑is, you can talk about **how you would enhance it**:

- Persist contacts to a cloud database on each provider.
- Add authentication / authorization.
- Use a shared API schema (e.g., OpenAPI) for all clouds.
- Build CI/CD pipelines that deploy each function automatically.

This is a clean, realistic project that you can walk through confidently in interviews.
