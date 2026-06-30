# GCP Monitoring Build

1. Open Monitoring > Alerting.
2. Create a notification channel using email.
3. Create an uptime check for the web VM external IP.
4. Create an alert policy for uptime check failure.
5. Create a dashboard with CPU, network bytes, and uptime status.

Validation: trigger a test incident by stopping Nginx temporarily, then restart it.
