# Security Considerations

## IAM Least Privilege
The Lambda function uses a dedicated IAM role. DynamoDB permissions are limited to the specific `insurance_quotes` table instead of using broad account-wide access.

## Data Protection
DynamoDB server-side encryption is enabled. Point-in-time recovery is also enabled to support recovery from accidental writes or deletes.

## API Gateway Controls
The HTTP API uses defined routes and throttling settings to reduce accidental overload. For production, CORS should be restricted to trusted domains instead of `*`.

## Logging
CloudWatch Logs capture Lambda execution details for troubleshooting. Sensitive customer data should not be printed into logs.

## Production Improvements
- Add authentication with Amazon Cognito or JWT authorizers.
- Restrict CORS origins.
- Add AWS WAF for edge protection.
- Store secrets in AWS Secrets Manager if external services are added.
