# Migration Plan: AWS Database Migration Service (DMS)

## Objective
Migrate an on-prem PostgreSQL database to AWS RDS PostgreSQL with minimal downtime.

## Steps
1. **Assess source**
   - Confirm source version and network access
   - Validate schema compatibility
2. **Create replication instance**
   - Place in private subnet with connectivity to source and target
3. **Create endpoints**
   - Source endpoint: on-prem DB
   - Target endpoint: RDS endpoint from Terraform output
4. **Run test task**
   - Full load + CDC (change data capture) if required
5. **Cutover**
   - Stop writes briefly or rely on CDC
   - Validate row counts and app connectivity
6. **Post-migration**
   - Enable backups, monitoring, alarms
