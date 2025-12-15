## Rollback Plan

Triggers:
- validation failures
- high error/timeout rate
- unexpected performance issues

Steps:
1) Freeze writes
2) Switch app back to source
3) Stop migration job and preserve logs
4) Communicate rollback and remediation path
