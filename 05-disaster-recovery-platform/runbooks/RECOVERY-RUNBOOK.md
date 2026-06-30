# Recovery Runbook

## Scenario
A web server VM is unavailable or deleted and must be restored.

## Recovery Steps

1. Confirm incident scope.
2. Identify latest healthy backup or snapshot.
3. Restore the VM or disk in the same region.
4. Reattach network/security configuration.
5. Validate SSH access.
6. Validate application service status.
7. Update DNS or public IP if required.
8. Document recovery time and lessons learned.

## Validation Commands

```bash
systemctl status nginx
curl localhost
```
