## Cutover Plan (GCP DMS)

1) Validate source prerequisites (replication slots/WAL, permissions)
2) Create Cloud SQL target (HA, flags, users, networking)
3) Configure DMS continuous migration job
4) Allow catch-up until lag is minimal
5) Freeze writes (maintenance mode)
6) Final validation checks (counts, critical tables, sample checksums)
7) Switch app to Cloud SQL endpoint
8) Monitor errors/latency and approve completion
