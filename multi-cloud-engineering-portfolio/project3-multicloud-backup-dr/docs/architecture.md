# Architecture – Multi‑Cloud Backup & DR Blueprint

## Scenario

- **Primary Cloud:** AWS
- **Secondary Cloud:** Azure
- **Tertiary Cloud:** GCP (archive only)

Example application:

- Web app on **EC2 Auto Scaling Group**
- Database on **Amazon RDS (MySQL)**

---

## High‑Level Design

1. **Application Layer (AWS)**
   - Load Balancer → Auto Scaling EC2 instances.
   - RDS Multi‑AZ for basic high availability.

2. **Backup & Replication**

   - **Database**
     - Daily automated RDS snapshots.
     - Weekly snapshot export to **S3 backup bucket**.
     - Replication of snapshots to:
       - **Azure Blob Storage** using AWS DataSync / AzCopy.
       - **GCP Cloud Storage** using Storage Transfer Service.

   - **Static Assets**
     - Application assets and user uploads stored in **S3**.
     - Nightly cross‑cloud sync to:
       - Azure Storage container.
       - GCS bucket configured for nearline or coldline storage.

3. **Azure Warm Standby**

   - Azure VM Scale Set (or App Service) template prepared but not always running.
   - Azure Database for MySQL server provisioned with:
     - Daily imports from the replicated RDS snapshots.
   - Azure Front Door / Azure Load Balancer ready to front the application.

4. **GCP Cold Archive**

   - GCS bucket with **lifecycle rules**:
     - Move data to Nearline/Coldline/Archive after N days.
   - These backups are for **legal/compliance** or worst‑case DR.

---

## RPO/RTO Considerations

- **RPO:** 15 minutes – 24 hours (depending on backup frequency).
- **RTO:** 1 – 4 hours to fail over to Azure if AWS region is unavailable.

You can discuss how you would adjust these knobs for stricter SLAs.
