# Deployment Guide

## Prerequisites
- AWS account
- Terraform installed
- AWS CLI configured with permissions to create Lambda, IAM, DynamoDB, API Gateway, and CloudWatch resources

## Deployment Steps
1. Open a terminal.
2. Navigate to the Terraform folder:
   ```bash
   cd terraform
   ```
3. Initialize Terraform:
   ```bash
   terraform init
   ```
4. Format and validate configuration:
   ```bash
   terraform fmt
   terraform validate
   ```
5. Preview infrastructure changes:
   ```bash
   terraform plan
   ```
6. Deploy resources:
   ```bash
   terraform apply
   ```
7. Copy the output named `quote_test_url`.
8. Open the URL in a browser to test the API.

## Destroy Resources
To avoid unnecessary charges:
```bash
terraform destroy
```
