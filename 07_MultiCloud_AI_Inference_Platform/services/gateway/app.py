
import os, time, json, hashlib
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import httpx
import redis

REDIS_HOST = os.getenv("REDIS_HOST", "localhost")
REDIS_PORT = int(os.getenv("REDIS_PORT", "6379"))

BACKENDS = {
    "us-east": os.getenv("BACKEND_US_EAST", "http://localhost:9101"),
    "us-west": os.getenv("BACKEND_US_WEST", "http://localhost:9102"),
    "eu-central": os.getenv("BACKEND_EU_CENTRAL", "http://localhost:9103"),
}
CACHE_TTL = int(os.getenv("CACHE_TTL_SECONDS", "120"))
RATE_LIMIT_RPM = int(os.getenv("RATE_LIMIT_RPM", "60"))

r = redis.Redis(host=REDIS_HOST, port=REDIS_PORT, decode_responses=True)

app = FastAPI(title="inference-gateway", version="1.0.0")

class InferRequest(BaseModel):
    user_id: str
    prompt: str

def route_region(user_id: str) -> str:
    # deterministic routing for cache locality
    h = int(hashlib.sha256(user_id.encode()).hexdigest(), 16)
    regions = list(BACKENDS.keys())
    return regions[h % len(regions)]

def rate_limit(user_id: str):
    # token bucket approximation per-minute
    window = int(time.time() // 60)
    key = f"rl:{user_id}:{window}"
    count = r.incr(key)
    if count == 1:
        r.expire(key, 70)
    if count > RATE_LIMIT_RPM:
        raise HTTPException(status_code=429, detail="Rate limit exceeded")

@app.get("/health")
def health():
    return {"status":"ok","backends":list(BACKENDS.keys())}

@app.post("/v1/infer")
def infer(req: InferRequest):
    rate_limit(req.user_id)

    cache_key = "cache:" + hashlib.sha256((req.user_id + "|" + req.prompt).encode()).hexdigest()
    cached = r.get(cache_key)
    if cached:
        payload = json.loads(cached)
        payload["cache"] = "HIT"
        return payload

    region = route_region(req.user_id)
    url = BACKENDS[region] + "/infer"

    with httpx.Client(timeout=10.0) as client:
        resp = client.post(url, json=req.model_dump())
        resp.raise_for_status()
        payload = resp.json()

    payload["cache"] = "MISS"
    payload["routed_region"] = region
    r.setex(cache_key, CACHE_TTL, json.dumps(payload))
    return payload
