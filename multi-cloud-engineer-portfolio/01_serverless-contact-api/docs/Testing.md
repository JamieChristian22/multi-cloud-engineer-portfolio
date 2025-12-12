# 🧪 Testing – Multi-Cloud Serverless Contact API

This guide explains how to verify that the Contact API behaves consistently across AWS, Azure, and GCP.

---

## 1. Manual Tests

Assume your base URLs are:

- `BASE_URL_AWS`
- `BASE_URL_AZURE`
- `BASE_URL_GCP`

### 1.1 Create a Contact

```bash
curl -X POST "$BASE_URL/contacts"   -H "Content-Type: application/json"   -d '{
    "first_name": "Jamie",
    "last_name": "Christian",
    "email": "jamie@example.com",
    "phone": "+1-555-555-5555"
  }'
```

Expected:

- `201 Created`
- Response body with `id` and stored fields.

### 1.2 Get a Contact

```bash
curl -X GET "$BASE_URL/contacts/<CONTACT_ID>"
```

Expected:

- `200 OK`
- Response JSON matches the created record.

### 1.3 Delete a Contact

```bash
curl -X DELETE "$BASE_URL/contacts/<CONTACT_ID>"
```

Expected:

- `204 No Content`
- Subsequent GET returns `404 Not Found`.

---

## 2. Cross-Cloud Parity

1. Repeat the tests using each cloud base URL.
2. Compare:
   - Status codes
   - JSON structure
   - Error messages for invalid input

The goal is to demonstrate **equivalent behavior**, even though the infrastructure differs.

---

## 3. Logging Checks

- **AWS:** Check CloudWatch Logs for Lambda invocations.
- **Azure:** Use Azure Portal → Functions → Monitor / Log Stream.
- **GCP:** Use Cloud Logging and filter by function name.

---

## 4. Basic Load Test (Optional)

To show that the design scales, you can send a quick burst of 50–100 requests
using any load tool (e.g., `hey`, `ab`, or a small Python script) and show:

- Low error rate
- Reasonable latency
- No unexpected throttling
