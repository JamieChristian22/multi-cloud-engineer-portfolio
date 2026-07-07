# DR Architecture

This platform uses a multi-cloud disaster recovery design:

- AWS Backup Vault + cross-region copy
- Azure Recovery Services Vault + geo-redundant storage
- GCP versioned storage buckets + audit log sink
- Central documentation for RTO, RPO, and recovery testing

## Recommended diagram sections

- Primary region
- DR region
- Backup vault
- Replicated storage
- Monitoring and alerting
- Restore workflow
