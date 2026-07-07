# 04-monitoring-platform — Terraform

This Terraform package builds a multi-cloud monitoring and observability foundation for the `04-monitoring-platform` project.

## What this creates

- AWS CloudWatch log groups, dashboards, alarms, SNS alerting, and metric filters
- Azure Log Analytics workspace, Application Insights, action groups, alerts, and diagnostic settings structure
- GCP Cloud Monitoring notification channels, alert policies, dashboards, and log sinks
- Environment examples for dev and prod
- Validation scripts for formatting and Terraform checks
- Portfolio documentation showing what to screenshot and explain

## Folder structure

```text
04-monitoring-platform/
└── terraform/
    ├── aws/
    ├── azure/
    ├── gcp/
    ├── modules/
    │   ├── aws-observability/
    │   ├── azure-observability/
    │   └── gcp-observability/
    ├── environments/
    │   ├── dev/
    │   └── prod/
    ├── scripts/
    └── docs/
```

## Usage

```bash
cd 04-monitoring-platform/terraform/aws
terraform init
terraform validate
terraform plan -var-file="../environments/dev/aws.tfvars"
```

Repeat for `azure` and `gcp` folders.

## Portfolio evidence to capture

1. Terraform validation success
2. Terraform plan output
3. CloudWatch dashboard and alarms
4. Azure Log Analytics workspace and alerts
5. GCP Monitoring dashboard and alert policies
6. Notification channel or action group configuration
7. Log retention / governance settings
8. Final architecture diagram

## Notes

This package is designed to be portfolio-ready and safe to customize. Review variables before applying to a real cloud account.
