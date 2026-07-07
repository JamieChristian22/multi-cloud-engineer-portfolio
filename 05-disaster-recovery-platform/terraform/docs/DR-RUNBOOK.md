# Disaster Recovery Runbook

## Recovery objectives

- Target RTO: 4 hours
- Target RPO: 24 hours
- Primary strategy: backup and restore with cross-region replication
- Secondary strategy: restore critical data into DR region

## Recovery process

1. Confirm incident scope.
2. Freeze risky changes.
3. Identify last healthy backup.
4. Restore infrastructure from Terraform.
5. Restore application data from backup vault or storage replica.
6. Validate network access, identity, logging, and security controls.
7. Complete smoke testing.
8. Document recovery time, data loss, and lessons learned.

## Evidence checklist

- Terraform plan output
- Backup policy screenshot
- Backup vault screenshot
- Replicated storage screenshot
- Monitoring alert screenshot
- Restore test notes
