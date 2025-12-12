# 📡 Multi-Cloud Serverless Contact API (AWS · Azure · GCP)

This project implements a **Contact directory API** that can be deployed natively to:

- **AWS** – API Gateway + Lambda
- **Azure** – Azure Functions (+ optional API Management)
- **GCP** – Cloud Functions (+ optional API Gateway)

All three implementations share the **same REST contract**, making it easy for a client to switch clouds by updating
only the base URL.

---

## 🎯 Use Case

A team needs a simple contact service that:

- Creates, reads, and deletes **Contact** records
- Can be hosted in whichever cloud the client prefers
- Uses cheap, serverless infrastructure and built-in storage

---

## 🧪 API Contract

**Base path:** `/contacts`

| Method | Path              | Description                    |
|--------|-------------------|--------------------------------|
| POST   | `/contacts`       | Create a new contact           |
| GET    | `/contacts/{id}`  | Retrieve contact by ID         |
| DELETE | `/contacts/{id}`  | Delete contact by ID           |
| GET    | `/contacts`       | (Optional) List all contacts   |

**Example payload:**

```json
{
  "id": "uuid-or-guid",
  "first_name": "Jamie",
  "last_name": "Christian",
  "email": "jamie@example.com",
  "phone": "+1-555-555-5555",
  "tags": ["internal", "engineering"]
}
```

---

## 🧰 Tech Stack

- **Language:** Python
- **AWS:** API Gateway, Lambda, DynamoDB (or S3), CloudWatch Logs
- **Azure:** Azure Functions (HTTP trigger), Table Storage / Cosmos DB, Azure Monitor
- **GCP:** Cloud Functions (HTTP), Firestore / Cloud Storage, Cloud Logging
- **IaC (optional):** Terraform modules (buckets/tables/permissions)

---

## 🏗 Architecture

Each cloud has the same pattern:

1. HTTP request hits API endpoint (API Gateway / Function URL / API Gateway on GCP).
2. Serverless function runs Python handler.
3. Handler validates input and interacts with a cloud-native data store.
4. Handler returns structured JSON + HTTP status.
5. Logs are emitted to the respective logging service.

See: `docs/Architecture.md` and `docs/Architecture.png` for visuals.

---

## 🚀 Deployment & Testing

- Cloud-specific deployment steps are in `docs/Deployment.md`.
- Manual and parity testing instructions are in `docs/Testing.md`.

---

## 🔐 Security & Cost

See `docs/Security_And_Cost.md` for:

- Least-privilege guidelines
- Environment separation (dev / test / prod)
- Basic cost levers (timeouts, memory, storage type)

---

## ✅ Interview Talking Points

- Designing for **API parity** across different clouds
- Hiding infrastructure differences behind the same REST interface
- Trade-offs of using serverless and cloud-native data stores
- How IAM/RBAC differs across AWS, Azure, and GCP and how you handled it
