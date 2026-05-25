# Kubernetes Deployment Guide

## Overview
This project demonstrates deploying a Dockerized Flask application into Kubernetes using namespaces, deployments, and services.

## Deployment Steps

### Build Docker Image
```bash
docker build -t cloud-insurance-app:1.0 -f docker/Dockerfile .
```

### Run Locally
```bash
docker run -p 8080:8080 cloud-insurance-app:1.0
```

### Deploy to Kubernetes
```bash
kubectl apply -f kubernetes/namespace.yaml
kubectl apply -f kubernetes/deployment.yaml
kubectl apply -f kubernetes/service.yaml
```

### Verify Pods
```bash
kubectl get pods -n cloud-portfolio
```

### Verify Services
```bash
kubectl get svc -n cloud-portfolio
```

## Monitoring
```bash
kubectl logs -n cloud-portfolio -l app=cloud-insurance-app
```
