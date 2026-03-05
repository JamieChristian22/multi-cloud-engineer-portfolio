#!/usr/bin/env bash
set -euo pipefail

NAMESPACE="$1"
OVERLAY_PATH="$2"

kubectl create namespace "$NAMESPACE" --dry-run=client -o yaml | kubectl apply -f -

kustomize build "$OVERLAY_PATH" | kubectl apply -n "$NAMESPACE" -f -

echo "Waiting for rollouts..."
kubectl -n "$NAMESPACE" rollout status deploy/user-service --timeout=180s
kubectl -n "$NAMESPACE" rollout status deploy/catalog-service --timeout=180s
kubectl -n "$NAMESPACE" rollout status deploy/order-service --timeout=180s

echo "✅ Deployment complete in namespace: $NAMESPACE"
