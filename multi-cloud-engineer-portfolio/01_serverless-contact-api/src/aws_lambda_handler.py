import json
from typing import Any, Dict
from .repository import handle_request


def lambda_handler(event: Dict[str, Any], _context: Any) -> Dict[str, Any]:
    """AWS Lambda entrypoint for API Gateway proxy integration."""
    method = event.get("httpMethod", "GET")
    path = event.get("path", "/")
    body = event.get("body")

    status_code, headers, response_body = handle_request(method, path, body)

    return {
        "statusCode": status_code,
        "headers": headers,
        "body": json.dumps(response_body),
    }


if __name__ == "__main__":
    # Simple local test
    test_event = {
        "httpMethod": "POST",
        "path": "/contacts",
        "body": json.dumps({"name": "Test User", "email": "test@example.com"}),
    }
    print(lambda_handler(test_event, None))
