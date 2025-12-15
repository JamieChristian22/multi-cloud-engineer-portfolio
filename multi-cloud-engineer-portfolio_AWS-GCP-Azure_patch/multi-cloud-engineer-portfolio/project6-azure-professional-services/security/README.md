# Security Posture (Azure)

## Identity & Access
- Prefer Managed Identity for production registries and secrets
- For this demo, ACR admin is enabled to keep the project self-contained;
  in client environments, disable admin and use RBAC + managed identity.

## Network Boundary Controls
- Container Apps ingress can be external or internal
- Restrict inbound with WAF/Front Door in enterprise setups
- Use private endpoints for ACR and logging where required

## Audit Readiness
- Enable Azure Activity Logs and centralize to Log Analytics/SIEM
