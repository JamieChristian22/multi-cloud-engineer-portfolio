# Observability Stack (Kubernetes)

This folder provides a clean reference deployment for a Kubernetes cluster.

Includes:
- Prometheus config
- Alert rules
- Grafana datasource definition

Apply with:
```bash
kubectl apply -f manifests/
```

(For production, install via Helm charts and manage values through GitOps.)
