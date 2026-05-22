aws_region          = "us-east-1"
project_name        = "insurance-quote-serverless"
environment         = "dev"
lambda_runtime      = "python3.12"
lambda_timeout      = 10
lambda_memory_size  = 128
log_retention_days  = 14
allowed_cors_origins = ["*"]

common_tags = {
  Owner       = "Jamie Christian"
  Portfolio   = "Multi-Cloud Engineering"
  Project     = "AWS Serverless Insurance Quote API"
  ManagedBy   = "Terraform"
}
