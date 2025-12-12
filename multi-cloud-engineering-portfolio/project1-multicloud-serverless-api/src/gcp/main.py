import json
import uuid
from typing import Any, Dict, List

from flask import Request, make_response

CONTACTS: List[Dict[str, Any]] = []


def _json(status_code: int, body: Dict[str, Any]):
    response = make_response(json.dumps(body), status_code)
    response.headers["Content-Type"] = "application/json"
    return response


def entry_point(request: Request):
    """
    Google Cloud Functions HTTP entry point.

    Routes:
    - GET /contacts
    - POST /contacts
    - GET /health
    """
    method = request.method
    path = request.path or "/"

    if path.endswith("/health"):
        return _json(200, {"status": "ok"})

    if path.endswith("/contacts"):
        if method == "GET":
            return _json(200, {"message": "Contacts retrieved", "data": CONTACTS})

        if method == "POST":
            try:
                body = request.get_json(force=True, silent=False) or {}
            except Exception:
                return _json(400, {"message": "Invalid JSON body.", "data": None})

            name = body.get("name")
            email = body.get("email")
            if not name or not email:
                return _json(
                    400,
                    {"message": "Both 'name' and 'email' are required.", "data": None},
                )

            contact = {"id": str(uuid.uuid4()), "name": name, "email": email}
            CONTACTS.append(contact)
            return _json(201, {"message": "Contact created", "data": contact})

    return _json(404, {"message": f"Route {method} {path} not found.", "data": None})
