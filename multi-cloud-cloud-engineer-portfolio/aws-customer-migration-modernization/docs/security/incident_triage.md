# Security Incident Triage (Cloud Engineer)

## First 15 minutes
1. Identify impacted system: ALB/ECS/RDS/IAM
2. Freeze changes:
   - Disable CI apply workflow if it’s contributing
   - Limit operator actions to read-only until scope is known
3. Gather evidence:
   - CloudWatch Logs: app stream(s)
   - ECS events (service + tasks)
   - CloudTrail (if enabled in account)
4. Contain:
   - Tighten security groups if exposure is suspected
   - Rotate credentials if compromise is suspected

## Communication
- Provide a short status update: scope, containment steps, next update time
- Engage security owner and customer contact

## Recovery
- Roll back deployment if necessary
- Validate service health endpoints
- Post-incident: document root cause and preventive actions
