# DR Runbook – AWS to Azure / GCP

## 1. Detect Incident

- Monitor for:
  - AWS region outage
  - RDS unavailability
  - Critical app failure that cannot be mitigated

## 2. Declare DR Event

- Incident commander declares DR Level 1 or Level 2.
- Communicate to stakeholders via agreed channels (Slack, email, etc.).

## 3. Prepare Azure Environment (Warm Standby)

1. Confirm that the latest database backup has been replicated to Azure Blob.
2. Restore/import backup into **Azure Database for MySQL**.
3. Scale up **Azure VM Scale Set** or App Service:
   - Configure environment variables.
   - Point app to Azure Database endpoint.
4. Update **DNS**:
   - Switch the primary app CNAME from AWS Load Balancer to Azure Front Door or Azure public endpoint.
5. Run smoke tests:
   - `/health`
   - basic CRUD operations.

## 4. GCP Cold Archive (Extreme Scenario)

If both AWS and Azure are impacted or you need historical recovery:

1. Restore the latest backups from **GCS**.
2. Provision compute (GKE / Cloud Run / GCE) and database (Cloud SQL).
3. Deploy application using IaC or documented steps.
4. Update DNS to point to GCP.

## 5. Return to Normal

Once AWS is stable:

1. Decide whether to:
   - Stay temporarily on Azure (if incident is ongoing).
   - Migrate back to AWS as primary.

2. Reverse‑sync data:
   - From Azure → AWS RDS and S3.
   - Re‑enable AWS as primary endpoint in DNS.

3. Conduct a **post‑incident review**:
   - What worked / what failed.
   - Update runbook and automation.

This runbook gives you a concrete, professional script to walk through in interviews.
