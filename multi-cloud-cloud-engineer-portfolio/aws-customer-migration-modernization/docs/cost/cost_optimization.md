# Cost Optimization Review

## Implemented
- ECS Service autoscaling based on CPU target tracking (50%)
- Log retention set to 30 days (reduces logging spend vs infinite retention)
- RDS instance class selected as `db.t4g.micro` for dev footprint

## Right-sizing Guidance
- Monitor ECS CPU/memory utilization:
  - If CPU avg < 20% and memory < 30% for 7 days, reduce task size or desired count
- Monitor ALB request count:
  - If stable low traffic, consider reducing desired count to 1 in dev

## Waste Elimination
- Ensure `terraform destroy` for ephemeral environments
- Use S3 lifecycle for build artifacts if storing large objects
- Avoid over-provisioned NAT gateways in dev (this project uses 1 NAT gateway)
