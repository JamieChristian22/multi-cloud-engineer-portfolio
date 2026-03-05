
import os, time, hashlib
from fastapi import FastAPI
from pydantic import BaseModel

REGION = os.getenv("REGION", "us-east")
PORT = int(os.getenv("PORT", "9101"))

app = FastAPI(title=f"model-backend-{REGION}", version="1.0.0")

class InferRequest(BaseModel):
    user_id: str
    prompt: str

class InferResponse(BaseModel):
    region: str
    response: str
    model_version: str
    latency_ms: int

@app.get("/health")
def health():
    return {"status":"ok","region":REGION}

@app.post("/infer", response_model=InferResponse)
def infer(req: InferRequest):
    # Simulate compute latency (as if calling a model)
    start = time.time()
    time.sleep(0.18 if REGION == "us-east" else 0.22 if REGION == "us-west" else 0.26)

    # Deterministic "response" for repeatability
    h = hashlib.sha256((req.user_id + "|" + req.prompt + "|" + REGION).encode()).hexdigest()[:12]
    resp = f"[{REGION}] Insight({h}): Orders show stable demand; optimize inventory for top SKUs and monitor return rates."

    latency = int((time.time() - start) * 1000)
    return InferResponse(region=REGION, response=resp, model_version="stub-2026.03", latency_ms=latency)
