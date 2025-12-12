import json
from typing import Any

try:
    import azure.functions as func  # type: ignore
except ImportError:  # allows local testing without azure-functions installed
    func = None  # type: ignore

from .repository import handle_request


def main(req: Any) -> Any:
    """Azure Functions HTTP trigger entrypoint."""
    method = getattr(req, "method", "GET")
    # Depending on your route config, this may vary; fallback to URL path.
    path = getattr(req, "route_params", {}).get("path", getattr(req, "url", "/"))
    try:
        body_text = req.get_body().decode("utf-8")
    except Exception:
        body_text = None

    status_code, headers, response_body = handle_request(method, path, body_text)

    if func is None:
        # Fallback for local testing without azure.functions
        return {
            "status_code": status_code,
            "headers": headers,
            "body": response_body,
        }

    return func.HttpResponse(
        body=json.dumps(response_body),
        status_code=status_code,
        headers=headers,
        mimetype="application/json",
    )
