
# 07 — Multi-Cloud AI Inference Platform (Distributed Systems)

## Goal
Demonstrate a **top‑tier platform engineering** pattern:
- Global **Inference Gateway** (FastAPI)
- **Routing** to multiple "regional" model backends (simulated locally)
- **Redis caching** to reduce latency + cost
- **Rate limiting** (token bucket)
- **Observability hooks** (OpenTelemetry-ready)
- Kubernetes manifests + Helm chart patterns for running on EKS/AKS/GKE

This is designed to look like an enterprise multi-cloud inference service that could front LLMs or ML models.

---

## Architecture (Conceptual)

```text
Clients
  |
  v
Global Inference Gateway (FastAPI)
  |        |
  |        +--> Redis Cache (response cache + rate limit counters)
  |
  +--> Regional Backends:
         - us-east (FastAPI model stub)
         - us-west (FastAPI model stub)
         - eu-central (FastAPI model stub)

(Each backend could be replaced with:
 Vertex AI / SageMaker / Azure ML / custom GPU inference)
```

---

## Local Demo (Runnable)

### 1) Start services
```bash
docker compose up --build
```

### 2) Call the gateway
```bash
curl -X POST http://localhost:9000/v1/infer \
  -H "Content-Type: application/json" \
  -d '{"user_id":"CUST1001","prompt":"Summarize order trends for February."}'
```

### 3) What you should see
- First request: routed to a region (e.g. us-east) and cached
- Subsequent identical request: served from cache (faster)

---

## Production Notes (Multi-Cloud)
- Gateway runs in **active-active** across 2+ clusters
- Cache can be:
  - managed Redis (Elasticache / Azure Cache for Redis / Memorystore)
- Backends can be:
  - GPU deployments (Kubernetes + node pools)
  - managed ML (Vertex/SageMaker/Azure ML endpoints)
- Traffic management can be:
  - Global LB + DNS latency routing
  - Service mesh routing (Istio)

---

## What This Proves
- Distributed systems thinking: caching, routing, rate limits
- Multi-cloud platform architecture
- Practical production patterns recruiters look for
