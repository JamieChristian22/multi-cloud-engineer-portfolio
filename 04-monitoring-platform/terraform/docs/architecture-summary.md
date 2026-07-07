# Architecture Summary — Multi-Cloud Monitoring Platform

## AWS

- CloudWatch Log Group for application logs
- CloudWatch Metric Alarm for CPU threshold monitoring
- Metric Filter for application error detection
- SNS Topic and email subscription for alerts
- CloudWatch Dashboard for visibility

## Azure

- Resource Group dedicated to monitoring
- Log Analytics Workspace for centralized logs
- Application Insights for web application telemetry
- Action Group for alert routing
- Metric Alert for availability monitoring

## GCP

- Cloud Monitoring email notification channel
- Uptime check for web endpoint availability
- Alert policy for uptime failures
- Centralized Logging bucket with retention
- Monitoring dashboard for visibility

## Skills demonstrated

- Terraform infrastructure as code
- Observability engineering
- Cloud monitoring design
- Alerting and incident response basics
- Multi-cloud governance
- Cost-aware log retention
