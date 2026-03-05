# Zero Trust Reference Design (AWS + Azure + GCP)

## Principles Applied
1. **Strong identity**: every workload has a verifiable identity.
2. **Least privilege**: policies are narrow (actions + resources).
3. **Assume breach**: segment networks and require authZ at each hop.
4. **Continuous verification**: logs + anomaly detection.
5. **No long-lived secrets**: prefer federation / managed identity.

---

## Threat Model (Concrete)
- Stolen kubeconfig / cluster-admin token
- Leaked application secret from CI logs
- Lateral movement between namespaces
- Compromised container image
- Exfiltration from object storage

---

## Controls Implemented

### Identity
- AWS: IRSA (IAM Roles for Service Accounts)
- Azure: Managed Identity + Workload Identity
- GCP: Workload Identity Federation

### Secrets
- Preferred: cloud-native secret managers
- Optional: HashiCorp Vault for unified control plane
- CI: masked secrets + short-lived tokens

### Network
- Namespace isolation
- Deny-all, allow-by-need network policies
- Private endpoints for storage where possible

### Audit
- Centralized logs with immutable storage
- Daily policy diff checks
- High-risk action alerts (iam:PassRole, storage deletion)

---

## Interview Talking Points
- Why federation beats static keys
- How to design blast-radius boundaries
- How to detect and respond to access anomalies
