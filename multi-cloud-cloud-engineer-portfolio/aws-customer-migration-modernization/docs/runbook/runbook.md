# Operations Runbook

## Services
- ALB: HTTP listener on port 80, forwards to ECS target group
- ECS Fargate Service: 2 tasks (min), autoscaling up to 6 tasks
- RDS Postgres: private, encrypted, backups retained 7 days
- CloudWatch Logs: `/mission-cloud-demo-dev/app` retention 30 days

## Smoke Test
1. `terraform apply` completes
2. Get ALB DNS from Terraform output: `alb_dns_name`
3. Test:
   - `http://<alb_dns_name>/health` should return 200
   - `http://<alb_dns_name>/ready` should return 200 once RDS is reachable

## Troubleshooting
### 1) ALB returns 5xx
- Check target health in Target Group
- Check ECS task logs in CloudWatch
- Verify container health check path `/health`
- Confirm SG rules: ALB SG -> app SG inbound on container port

### 2) Tasks can't connect to DB
- Check RDS endpoint output `rds_endpoint`
- Confirm DB SG allows inbound from app SG on 5432
- Review `/ready` endpoint and app logs for connection errors
- Validate DB credentials (stored as task environment variables)

### 3) Deployment rollback
- ECS service retains previous task definition revisions
- If latest deployment is unhealthy, update service to prior task definition revision:
  - `aws ecs describe-services`
  - `aws ecs update-service --task-definition <previous>`

## Escalation Guide
- Infra issues (VPC/ALB/ECS/RDS provisioning): Cloud Engineer on-call
- App issues: application owner
- Security incidents: follow `docs/security/incident_triage.md`
