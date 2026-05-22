"""
AWS Lambda function for the Insurance Quote API.

This function receives HTTP query parameters from Amazon API Gateway,
calculates a simple insurance quote, writes the quote record to DynamoDB,
and returns a JSON response to the caller.
"""

import json
import os
import uuid
from datetime import datetime, timezone
from decimal import Decimal
from typing import Any, Dict

import boto3
from botocore.exceptions import ClientError

TABLE_NAME = os.environ.get("TABLE_NAME", "insurance_quotes")
AWS_REGION = os.environ.get("AWS_REGION", "us-east-1")

dynamodb = boto3.resource("dynamodb", region_name=AWS_REGION)
table = dynamodb.Table(TABLE_NAME)


def _response(status_code: int, body: Dict[str, Any]) -> Dict[str, Any]:
    """Return a standard API Gateway HTTP response."""
    return {
        "statusCode": status_code,
        "headers": {
            "Content-Type": "application/json",
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Methods": "GET,OPTIONS",
            "Access-Control-Allow-Headers": "Content-Type",
        },
        "body": json.dumps(body, default=str),
    }


def _risk_category(age: int, coverage: int) -> str:
    """Calculate a simple risk category for portfolio demo purposes."""
    if age >= 60 or coverage >= 1_000_000:
        return "High"
    if age >= 45 or coverage >= 500_000:
        return "Moderate"
    return "Standard"


def _monthly_quote(age: int, coverage: int, risk: str) -> Decimal:
    """Calculate estimated monthly premium using simple business rules."""
    base_rate = Decimal("0.00085")
    age_factor = Decimal("1.00")

    if age >= 60:
        age_factor = Decimal("1.85")
    elif age >= 45:
        age_factor = Decimal("1.35")
    elif age >= 30:
        age_factor = Decimal("1.10")

    risk_factor = {
        "Standard": Decimal("1.00"),
        "Moderate": Decimal("1.25"),
        "High": Decimal("1.60"),
    }[risk]

    monthly = Decimal(coverage) * base_rate * age_factor * risk_factor
    return monthly.quantize(Decimal("0.01"))


def lambda_handler(event: Dict[str, Any], context: Any) -> Dict[str, Any]:
    """Handle quote requests from API Gateway."""
    try:
        if event.get("requestContext", {}).get("http", {}).get("method") == "OPTIONS":
            return _response(200, {"message": "CORS preflight successful"})

        params = event.get("queryStringParameters") or {}
        age_raw = params.get("age")
        coverage_raw = params.get("coverage")
        insurance_type = params.get("type", "term_life")

        if age_raw is None or coverage_raw is None:
            return _response(
                400,
                {
                    "error": "Missing required query parameters.",
                    "required_parameters": ["age", "coverage"],
                    "example": "?age=35&coverage=500000&type=term_life",
                },
            )

        age = int(age_raw)
        coverage = int(coverage_raw)

        if age < 18 or age > 85:
            return _response(400, {"error": "Age must be between 18 and 85."})
        if coverage < 50_000 or coverage > 5_000_000:
            return _response(400, {"error": "Coverage must be between 50000 and 5000000."})

        risk = _risk_category(age, coverage)
        monthly_quote = _monthly_quote(age, coverage, risk)
        quote_id = str(uuid.uuid4())
        created_at = datetime.now(timezone.utc).isoformat()

        item = {
            "quote_id": quote_id,
            "created_at": created_at,
            "age": age,
            "coverage": coverage,
            "insurance_type": insurance_type,
            "risk": risk,
            "monthly_quote": monthly_quote,
            "currency": "USD",
            "source": "api_gateway_lambda",
        }

        table.put_item(Item=item)

        return _response(
            200,
            {
                "quote_id": quote_id,
                "risk": risk,
                "monthly_quote": float(monthly_quote),
                "currency": "USD",
                "insurance_type": insurance_type,
                "coverage": coverage,
                "message": "Quote generated successfully.",
            },
        )

    except ValueError:
        return _response(400, {"error": "Age and coverage must be valid numbers."})
    except ClientError as error:
        print(f"DynamoDB error: {error}")
        return _response(500, {"error": "Database write failed."})
    except Exception as error:
        print(f"Unexpected error: {error}")
        return _response(500, {"error": "Internal server error."})
