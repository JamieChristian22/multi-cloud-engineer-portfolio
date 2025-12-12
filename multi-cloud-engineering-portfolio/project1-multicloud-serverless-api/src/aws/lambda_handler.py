import json
import uuid
from typing import Any, Dict, List

# In-memory "database" for demo purposes
CONTACTS: List[Dict[str, Any]] = []


def _response(status_code: int, body: Dict[str, Any]) -> Dict[str, Any]:
    return {
        "statusCode": status_code,
        "headers": {"Content-Type": "application/json"},
        "body": json.dumps(body),
    }


def get_contacts() -> Dict[str, Any]:
    return _response(200, {"message": "Contacts retrieved", "data": CONTACTS})


def create_contact(body: Dict[str, Any]) -> Dict[str, Any]:
    name = body.get("name")
    email = body.get("email")

    if not name or not email:
        return _response(
            400,
            {"message": "Both 'name' and 'email' are required.", "data": None},
        )

    contact = {"id": str(uuid.uuid4()), "name": name, "email": email}
    CONTACTS.append(contact)
    return _response(201, {"message": "Contact created", "data": contact})


def health_check() -> Dict[str, Any]:
    return _response(200, {"status": "ok"})


def lambda_handler(event, context):
    """
    AWS Lambda entry point for API Gateway proxy integration.
    """
    method = event.get("httpMethod", "GET")
    path = event.get("path", "/")

    if path.endswith("/health"):
        return health_check()
    if path.endswith("/contacts"):
        if method == "GET":
            return get_contacts()
        if method == "POST":
            try:
                body = json.loads(event.get("body") or "{}")
            except json.JSONDecodeError:
                return _response(400, {"message": "Invalid JSON body.", "data": None})
            return create_contact(body)

    return _response(404, {"message": f"Route {method} {path} not found.", "data": None})
