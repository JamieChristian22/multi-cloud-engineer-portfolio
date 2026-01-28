from dataclasses import dataclass, asdict
from typing import Dict, Any
import uuid
import datetime


@dataclass
class Contact:
    id: str
    name: str
    email: str
    created_at: str

    @staticmethod
    def from_payload(payload: Dict[str, Any]) -> "Contact":
        if "name" not in payload or "email" not in payload:
            raise ValueError("Missing 'name' or 'email'")
        return Contact(
            id=str(uuid.uuid4()),
            name=str(payload["name"]).strip(),
            email=str(payload["email"]).strip(),
            created_at=datetime.datetime.utcnow().isoformat() + "Z",
        )

    def to_dict(self) -> Dict[str, Any]:
        return asdict(self)
