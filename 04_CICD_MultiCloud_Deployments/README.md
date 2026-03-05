# 04 — CI/CD for Multi-Cloud Kubernetes Deployments (GitHub Actions)

## Goal
A real pipeline that:
- runs tests
- builds Docker images
- generates SBOM + vulnerability scan (Trivy)
- pushes images to GHCR
- deploys to Kubernetes using Kustomize

This is how modern teams ship reliably across EKS/AKS/GKE.

---

## What’s Included
- `.github/workflows/ci.yml` — test + build + scan
- `.github/workflows/deploy.yml` — deploy on tag release
- `scripts/k8s_deploy.sh` — safe deploy with rollout status
- `kustomize/` — dev/prod overlays

---

## Required GitHub Secrets
- `KUBECONFIG_B64` — base64 encoded kubeconfig for your target cluster
- `GHCR_TOKEN` — a PAT with `write:packages` scope

---

## Workflow Summary
- On PR/Push: unit tests + build + trivy scan
- On tag `v*`: publish + deploy to `mc-prod`

