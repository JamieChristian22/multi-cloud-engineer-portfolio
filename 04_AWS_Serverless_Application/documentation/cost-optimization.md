# Cost Optimization

## Serverless First
This project uses Lambda and API Gateway HTTP API to avoid always-on compute costs.

## DynamoDB On-Demand
DynamoDB uses `PAY_PER_REQUEST`, which is appropriate for low-volume portfolio and development workloads.

## Log Retention
CloudWatch logs are retained for 14 days to avoid unnecessary long-term storage costs.

## Small Lambda Footprint
The Lambda function uses 128 MB memory and a 10-second timeout, which is enough for this lightweight API.

## Cleanup
Run the following when finished testing:
```bash
terraform destroy
```
