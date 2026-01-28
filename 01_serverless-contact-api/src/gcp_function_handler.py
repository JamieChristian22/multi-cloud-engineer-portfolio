import json
from typing import Any
from .repository import handle_request


def main(request: Any) -> Any:
    """Google Cloud Functions HTTP entrypoint."""
    method = request.method
    path = request.path  # e.g. "/contacts" or "/health"
    body_text = request.data.decode("utf-8") if request.data else None

    status_code, headers, response_body = handle_request(method, path, body_text)

    # GCP uses a Flask-like response object
    from flask import make_response  # type: ignore

    response = make_response(json.dumps(response_body), status_code)
    for k, v in headers.items():
        response.headers[k] = v
    return response
