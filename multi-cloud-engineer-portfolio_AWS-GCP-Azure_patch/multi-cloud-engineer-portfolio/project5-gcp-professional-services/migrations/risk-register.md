| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| Network throughput insufficient | Medium | Medium | Pre-stage bulk load off-peak; adjust migration resources |
| Replication lag spikes | Medium | High | Cutover off-peak; monitor lag; throttle app |
| Flag/extension mismatch | Low | High | Validate extensions/flags in staging |
| Cutover exceeds window | Low | High | Rehearse cutover; automate checks; keep rollback ready |
