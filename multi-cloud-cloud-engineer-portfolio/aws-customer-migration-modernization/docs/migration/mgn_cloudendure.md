# Migration Plan: AWS Application Migration Service (MGN) / CloudEndure

> CloudEndure has been integrated into AWS as **AWS Application Migration Service (MGN)** for lift-and-shift migrations.

## Objective
Migrate legacy VM-based application servers into AWS quickly while minimizing downtime, then modernize into containers.

## Steps
1. **Discovery**
   - Inventory servers, dependencies, and data flows
   - Confirm OS compatibility for replication agent
2. **Prepare AWS**
   - Create staging area subnet(s) and security group rules
   - Ensure IAM permissions for MGN service
3. **Install agents**
   - Install MGN replication agent on each source server
   - Verify replication health in the MGN console
4. **Test launch**
   - Launch test instances into isolated test subnet
   - Validate app boot, service reachability, and logs
5. **Cutover**
   - Schedule cutover window
   - Launch cutover instances
   - Update DNS / traffic routing
6. **Post-migration**
   - Validate metrics and logs
   - Document changes and handoff

## Modernization Path (what this repo implements)
- Containerize app -> ECS Fargate
- Replace lift-and-shift DB with managed RDS
- Centralize logs -> CloudWatch Logs
- Manage infra via Terraform
