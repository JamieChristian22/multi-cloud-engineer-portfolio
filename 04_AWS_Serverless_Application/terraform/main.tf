locals {
  name_prefix = "${var.project_name}-${var.environment}"
  lambda_name = "${local.name_prefix}-lambda"
  table_name  = "insurance_quotes"
}

data "archive_file" "lambda_package" {
  type        = "zip"
  source_file = "${path.module}/../lambda/lambda_function.py"
  output_path = "${path.module}/lambda_function.zip"
}

resource "aws_dynamodb_table" "insurance_quotes" {
  name         = local.table_name
  billing_mode = var.dynamodb_billing_mode
  hash_key     = "quote_id"

  attribute {
    name = "quote_id"
    type = "S"
  }

  point_in_time_recovery {
    enabled = true
  }

  server_side_encryption {
    enabled = true
  }

  tags = merge(var.common_tags, {
    Name        = local.table_name
    Environment = var.environment
    Service     = "DynamoDB"
  })
}

resource "aws_iam_role" "lambda_execution_role" {
  name = "${local.name_prefix}-lambda-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = merge(var.common_tags, {
    Name        = "${local.name_prefix}-lambda-execution-role"
    Environment = var.environment
    Service     = "IAM"
  })
}

resource "aws_iam_policy" "lambda_dynamodb_policy" {
  name        = "${local.name_prefix}-lambda-dynamodb-policy"
  description = "Least-privilege permissions for Lambda to write/read quote records in DynamoDB."

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "dynamodb:PutItem",
          "dynamodb:GetItem",
          "dynamodb:Query",
          "dynamodb:Scan"
        ]
        Resource = aws_dynamodb_table.insurance_quotes.arn
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "lambda_dynamodb_access" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = aws_iam_policy.lambda_dynamodb_policy.arn
}

resource "aws_cloudwatch_log_group" "lambda_logs" {
  name              = "/aws/lambda/${local.lambda_name}"
  retention_in_days = var.log_retention_days

  tags = merge(var.common_tags, {
    Name        = "/aws/lambda/${local.lambda_name}"
    Environment = var.environment
    Service     = "CloudWatch"
  })
}

resource "aws_lambda_function" "insurance_quote_api" {
  function_name    = local.lambda_name
  description      = "Serverless insurance quote API using API Gateway, Lambda, DynamoDB, and CloudWatch."
  role             = aws_iam_role.lambda_execution_role.arn
  handler          = "lambda_function.lambda_handler"
  runtime          = var.lambda_runtime
  filename         = data.archive_file.lambda_package.output_path
  source_code_hash = data.archive_file.lambda_package.output_base64sha256
  timeout          = var.lambda_timeout
  memory_size      = var.lambda_memory_size

  environment {
    variables = {
      TABLE_NAME  = aws_dynamodb_table.insurance_quotes.name
      ENVIRONMENT = var.environment
    }
  }

  depends_on = [
    aws_iam_role_policy_attachment.lambda_basic_execution,
    aws_iam_role_policy_attachment.lambda_dynamodb_access,
    aws_cloudwatch_log_group.lambda_logs
  ]

  tags = merge(var.common_tags, {
    Name        = local.lambda_name
    Environment = var.environment
    Service     = "Lambda"
  })
}

resource "aws_apigatewayv2_api" "insurance_quote_http_api" {
  name          = "${local.name_prefix}-http-api"
  description   = "HTTP API endpoint for the serverless insurance quote service."
  protocol_type = "HTTP"

  cors_configuration {
    allow_credentials = false
    allow_headers     = ["content-type"]
    allow_methods     = ["GET", "OPTIONS"]
    allow_origins     = var.allowed_cors_origins
    max_age           = 300
  }

  tags = merge(var.common_tags, {
    Name        = "${local.name_prefix}-http-api"
    Environment = var.environment
    Service     = "API Gateway"
  })
}

resource "aws_apigatewayv2_integration" "lambda_integration" {
  api_id                 = aws_apigatewayv2_api.insurance_quote_http_api.id
  integration_type       = "AWS_PROXY"
  integration_uri        = aws_lambda_function.insurance_quote_api.invoke_arn
  integration_method     = "POST"
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "quote_route" {
  api_id    = aws_apigatewayv2_api.insurance_quote_http_api.id
  route_key = "GET /quote"
  target    = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
}

resource "aws_apigatewayv2_route" "default_route" {
  api_id    = aws_apigatewayv2_api.insurance_quote_http_api.id
  route_key = "GET /"
  target    = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
}

resource "aws_apigatewayv2_stage" "default_stage" {
  api_id      = aws_apigatewayv2_api.insurance_quote_http_api.id
  name        = "$default"
  auto_deploy = true

  default_route_settings {
    throttling_burst_limit = 50
    throttling_rate_limit  = 25
  }

  tags = merge(var.common_tags, {
    Name        = "${local.name_prefix}-default-stage"
    Environment = var.environment
    Service     = "API Gateway"
  })
}

resource "aws_lambda_permission" "allow_api_gateway" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.insurance_quote_api.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.insurance_quote_http_api.execution_arn}/*/*"
}
