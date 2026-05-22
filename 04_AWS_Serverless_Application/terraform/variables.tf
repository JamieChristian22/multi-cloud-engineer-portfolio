variable "aws_region" {
  description = "AWS region used for the serverless application."
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Base project name used for AWS resource naming."
  type        = string
  default     = "insurance-quote-serverless"
}

variable "environment" {
  description = "Deployment environment name."
  type        = string
  default     = "dev"
}

variable "lambda_runtime" {
  description = "Runtime for the Lambda function."
  type        = string
  default     = "python3.12"
}

variable "lambda_timeout" {
  description = "Lambda timeout in seconds."
  type        = number
  default     = 10
}

variable "lambda_memory_size" {
  description = "Lambda memory allocation in MB."
  type        = number
  default     = 128
}

variable "dynamodb_billing_mode" {
  description = "Billing mode for DynamoDB. PAY_PER_REQUEST is best for portfolio/free-tier style usage."
  type        = string
  default     = "PAY_PER_REQUEST"
}

variable "log_retention_days" {
  description = "CloudWatch log retention period in days."
  type        = number
  default     = 14
}

variable "allowed_cors_origins" {
  description = "Allowed CORS origins for API Gateway."
  type        = list(string)
  default     = ["*"]
}

variable "common_tags" {
  description = "Common tags applied to supported resources."
  type        = map(string)
  default = {
    Owner       = "Jamie Christian"
    Portfolio   = "Multi-Cloud Engineering"
    Project     = "AWS Serverless Insurance Quote API"
    ManagedBy   = "Terraform"
  }
}
