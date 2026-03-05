from fastapi import FastAPI
from pydantic import BaseModel
from typing import List
import datetime as dt

app = FastAPI(title="user-service", version="1.0.0")

class Item(BaseModel):
    id: str
    name: str
    created_at: str

# In-memory store for demo portability (runs anywhere)
STORE: List[Item] = []

@app.get("/health")
def health():
    return {"status":"ok","service":"user-service","time":dt.datetime.utcnow().isoformat() + "Z"}

@app.get("/v1/customers", response_model=List[Item])
def list_items():
    return STORE

@app.post("/v1/customers", response_model=Item)
def add_item(item: Item):
    STORE.append(item)
    return item
