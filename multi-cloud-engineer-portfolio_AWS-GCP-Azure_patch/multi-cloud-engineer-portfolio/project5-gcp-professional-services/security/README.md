# Security Posture (GCP)

## Identity & Access
- Use a dedicated service account for CI/CD pushes to Artifact Registry
- Use least privilege roles:
  - Artifact Registry Writer for push
  - Cloud Run Admin (only if CI deploys revisions)

## Network Boundary Controls
- Cloud Run can be public (invoker allUsers) or private (recommended for enterprise)
- For private access:
  - remove public invoker
  - integrate with IAP or internal load balancer patterns

## Audit Readiness
- Enable Admin Activity audit logs (default)
- Centralize logs via sinks for enterprise environments
