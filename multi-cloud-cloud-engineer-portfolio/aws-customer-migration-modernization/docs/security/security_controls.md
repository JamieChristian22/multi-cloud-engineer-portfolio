# Security Controls & Remediation

## Implemented Controls
1. **Network boundary controls**
   - ECS tasks in private subnets (no public IP)
   - RDS not publicly accessible
   - ALB is the only public entry point
2. **Least privilege IAM**
   - Separate ECS task execution role and task role
   - Task role limited to CloudWatch log stream operations
3. **Encryption**
   - RDS encrypted at rest via KMS
   - Terraform remote state encrypted in S3
4. **Logging**
   - Application logs written to CloudWatch Logs
   - Retention set to 30 days for cost-control and compliance

## Common Security Gaps (and how this project fixes them)
- Overly permissive SG rules -> **DB ingress limited to app SG**
- Public databases -> **RDS placed in private subnets + not publicly accessible**
- No encryption -> **KMS-enabled RDS**
- No audit trail -> **CloudWatch centralized logs**

## Next Hardening Steps (Production)
- Replace plaintext DB password with Secrets Manager + task definition secrets injection
- Add HTTPS listener with ACM certificate on ALB
- Enable WAF on ALB
- Enable RDS Performance Insights + enhanced monitoring
