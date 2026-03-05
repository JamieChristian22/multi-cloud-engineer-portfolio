# 03 — Kubernetes Multi-Cloud Microservices (EKS / AKS / GKE)

## Goal
A microservices application that runs the same way on:
- AWS EKS
- Azure AKS
- Google GKE

Includes:
- 3 FastAPI services
- Dockerfiles
- Kubernetes manifests (deployment, service, ingress)
- Kustomize overlays for prod/dev
- Postgres backing service (optional local demo)

---

## Services
- `user-service` (customers)
- `order-service` (orders)
- `catalog-service` (products)

Each service:
- exposes a REST API
- includes health endpoints
- has unit tests
- has a Docker build

---

## Local Demo (Docker Compose)
```bash
docker compose up --build
```

Then:
- user-service: `http://localhost:8001/docs`
- catalog-service: `http://localhost:8002/docs`
- order-service: `http://localhost:8003/docs`

---

## Kubernetes Deploy (Any Cluster)

1) Build and push images to GHCR (or your registry)  
2) Apply k8s manifests:
```bash
kubectl apply -k k8s/overlays/dev
```

---

## What This Proves
- containerization + microservice design
- k8s deployments portable across clouds
- readiness/liveness probes and resource requests
