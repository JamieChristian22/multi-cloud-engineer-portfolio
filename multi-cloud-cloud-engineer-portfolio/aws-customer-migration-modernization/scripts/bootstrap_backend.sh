#!/usr/bin/env bash
set -euo pipefail

REGION="us-east-1"
STATE_BUCKET="jamie-terraform-state-bucket"
LOCK_TABLE="jamie-terraform-locks"

aws s3api create-bucket --bucket "$STATE_BUCKET" --region "$REGION" || true
aws s3api put-bucket-versioning --bucket "$STATE_BUCKET" --versioning-configuration Status=Enabled
aws s3api put-bucket-encryption --bucket "$STATE_BUCKET" --server-side-encryption-configuration '{"Rules":[{"ApplyServerSideEncryptionByDefault":{"SSEAlgorithm":"AES256"}}]}'

aws dynamodb create-table   --table-name "$LOCK_TABLE"   --attribute-definitions AttributeName=LockID,AttributeType=S   --key-schema AttributeName=LockID,KeyType=HASH   --billing-mode PAY_PER_REQUEST   --region "$REGION" || true

echo "Backend ready:"
echo "  S3 bucket: $STATE_BUCKET"
echo "  DynamoDB:  $LOCK_TABLE"
