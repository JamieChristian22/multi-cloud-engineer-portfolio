output "api_endpoint" {
  description = "Base endpoint URL for the HTTP API."
  value       = aws_apigatewayv2_api.insurance_quote_http_api.api_endpoint
}

output "quote_test_url" {
  description = "Ready-to-test URL for the quote endpoint."
  value       = "${aws_apigatewayv2_api.insurance_quote_http_api.api_endpoint}/quote?age=35&coverage=500000&type=term_life"
}

output "lambda_function_name" {
  description = "Name of the deployed Lambda function."
  value       = aws_lambda_function.insurance_quote_api.function_name
}

output "dynamodb_table_name" {
  description = "Name of the DynamoDB quote table."
  value       = aws_dynamodb_table.insurance_quotes.name
}

output "cloudwatch_log_group" {
  description = "CloudWatch log group for Lambda execution logs."
  value       = aws_cloudwatch_log_group.lambda_logs.name
}
