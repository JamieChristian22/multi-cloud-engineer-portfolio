# Backup Policy Matrix

| Asset Type        | Primary Location | Backup Location(s)              | Frequency          | Retention          | RPO Target | RTO Target |
|-------------------|------------------|---------------------------------|--------------------|--------------------|------------|-----------|
| App Source Code   | GitHub / Code    | AWS CodeCommit, Azure Repos     | On every commit    | Indefinite         | < 5 min    | N/A       |
| Web Server Config | EC2 User Data    | S3 + Azure Blob + GCS Archive   | Daily              | 30 days            | 24 hours   | 4 hours   |
| Database (Prod)   | AWS RDS (MySQL)  | S3 (snapshots), Azure Blob, GCS | Snapshots daily    | 35 days            | 24 hours   | 4 hours   |
| User Uploads      | S3               | Azure Blob, GCS                 | Nightly sync       | 90 days            | 24 hours   | 4 hours   |
| Logs              | CloudWatch Logs  | Export to S3 / Azure / GCS      | Hourly aggregation | 30 days            | 1 hour     | N/A       |

You can customize these values to match stricter or looser SLAs when discussing the design in interviews.
