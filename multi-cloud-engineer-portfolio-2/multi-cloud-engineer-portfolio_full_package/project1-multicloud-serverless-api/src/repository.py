import json
from typing import List, Dict, Any, Tuple
from .models import Contact

# In-memory store for demo; in production this would be a database.
_CONTACTS: List[Contact] = []


def list_contacts() -> List[Dict[str, Any]]:
    return [c.to_dict() for c in _CONTACTS]


def add_contact(payload: Dict[str, Any]) -> Dict[str, Any]:
    contact = Contact.from_payload(payload)
    _CONTACTS.append(contact)
    return contact.to_dict()


def handle_request(method: str, path: str, body: str | None) -> Tuple[int, Dict[str, str], Dict[str, Any]]:
    """
    Generic request handler used by AWS / Azure / GCP wrappers.

    Returns: (status_code, headers, body_dict)
    """
    headers = {"Content-Type": "application/json"}

    # Normalize path (strip leading /)
    path = path.lstrip("/")

    if path == "health":
        return 200, headers, {"status": "ok"}

    if path == "contacts":
        if method.upper() == "GET":
            return 200, headers, {"data": list_contacts()}
        if method.upper() == "POST":
            try:
                payload = json.loads(body or "{}")
                created = add_contact(payload)
                return 201, headers, {"data": created}
            except (json.JSONDecodeError, ValueError) as exc:
                return 400, headers, {"error": str(exc)}

    return 404, headers, {"error": "Not Found"}
