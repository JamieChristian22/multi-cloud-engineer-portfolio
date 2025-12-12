import json
import uuid
from typing import Any, Dict, List

import azure.functions as func

CONTACTS: List[Dict[str, Any]] = []


def _json_response(status_code: int, body: Dict[str, Any]) -> func.HttpResponse:
    return func.HttpResponse(
        status_code=status_code,
        body=json.dumps(body),
        mimetype="application/json",
    )


def main(req: func.HttpRequest) -> func.HttpResponse:
    """
    Azure Function HTTP trigger.

    To keep routing simple, we treat a query param "path" as the logical path:
    - ?path=/contacts
    - ?path=/health
    """
    path = req.params.get("path", "/")
    method = req.method.upper()

    if path.endswith("/health"):
        return _json_response(200, {"status": "ok"})

    if path.endswith("/contacts"):
        if method == "GET":
            return _json_response(
                200, {"message": "Contacts retrieved", "data": CONTACTS}
            )

        if method == "POST":
            try:
                body = req.get_json()
            except ValueError:
                return _json_response(
                    400, {"message": "Invalid JSON body.", "data": None}
                )

            name = body.get("name")
            email = body.get("email")
            if not name or not email:
                return _json_response(
                    400,
                    {"message": "Both 'name' and 'email' are required.", "data": None},
                )

            contact = {"id": str(uuid.uuid4()), "name": name, "email": email}
            CONTACTS.append(contact)
            return _json_response(
                201, {"message": "Contact created", "data": contact}
            )

    return _json_response(
        404, {"message": f"Route {method} {path} not found.", "data": None}
    )
