# Verification Plan

## Infrastructure
- VPC created with public/private subnets across 2 AZs
- NAT gateway provides outbound for private subnets
- ALB publicly reachable on port 80

## Application
- `/health` returns 200
- ECS tasks are healthy in Target Group
- CloudWatch logs show app startup + request logs

## Database
- RDS is private and encrypted
- App `/ready` returns 200 when DB connectivity is successful

## Security
- RDS ingress is only from app SG
- ECS tasks have no public IP
