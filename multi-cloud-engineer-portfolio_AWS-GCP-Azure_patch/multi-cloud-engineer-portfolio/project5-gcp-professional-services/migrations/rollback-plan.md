## Rollback Plan

Rollback triggers:
- Data validation failures
- Severe latency/timeout post-cutover
- Functional failures tied to DB behavior

Steps:
1) Freeze writes
2) Switch app back to source endpoint
3) Stop DMS job and preserve logs
4) Communicate rollback and remediation plan
