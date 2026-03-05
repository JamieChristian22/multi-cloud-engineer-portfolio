from sqlalchemy import create_engine
import os

def pg_engine():
    host = os.getenv("PG_HOST", "localhost")
    port = int(os.getenv("PG_PORT", "5432"))
    db = os.getenv("PG_DB", "ecommerce")
    user = os.getenv("PG_USER", "analytics")
    pw = os.getenv("PG_PASSWORD", "analytics_pw_2026")
    url = f"postgresql+psycopg2://{user}:{pw}@{host}:{port}/{db}"
    return create_engine(url, pool_pre_ping=True)
