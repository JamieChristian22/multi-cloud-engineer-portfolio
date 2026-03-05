# 05 — Zero Trust Security + Identity Federation (Multi-Cloud)

## Goal
Provide a **reference implementation** of multi-cloud security patterns:
- Least privilege IAM
- Identity federation (workload identity)
- Secrets management approach
- Network segmentation & policy
- Audit logging + baseline controls

This project is designed as a **security design pack** you can bring to interviews.

---

## What’s Included
- `docs/zero_trust_reference.md` — concrete design decisions
- `iam/aws/` — IAM role + policy JSON for service-to-service access
- `iam/azure/` — Azure RBAC + managed identity approach
- `iam/gcp/` — Workload Identity Federation + IAM bindings
- `secrets/` — Vault + cloud-native secrets patterns
- `audit/` — logging checklist + example queries

---

## Practical Scenario
A Kubernetes workload (microservices) needs to:
- Read objects from an analytics bucket
- Write metrics to monitoring
- Publish events to a queue

**Policy objective:** allow only what is necessary for that workload identity.

---

## Key Outputs
- Minimum IAM policy documents ready to apply
- Explicit threat model and control mapping
- Runbook: how to rotate creds and audit access
