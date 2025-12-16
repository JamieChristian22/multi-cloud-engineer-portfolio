import os
import time
from flask import Flask, jsonify
import psycopg2

app = Flask(__name__)

DB_HOST = os.getenv("DB_HOST")
DB_NAME = os.getenv("DB_NAME", "appdb")
DB_USER = os.getenv("DB_USER")
DB_PASS = os.getenv("DB_PASS")

def can_connect():
    if not (DB_HOST and DB_USER and DB_PASS):
        return False, "Database env vars missing"
    try:
        conn = psycopg2.connect(
            host=DB_HOST,
            dbname=DB_NAME,
            user=DB_USER,
            password=DB_PASS,
            connect_timeout=3,
        )
        cur = conn.cursor()
        cur.execute("SELECT 1;")
        _ = cur.fetchone()
        cur.close()
        conn.close()
        return True, "ok"
    except Exception as e:
        return False, str(e)

@app.get("/")
def root():
    ok, msg = can_connect()
    return jsonify({
        "service": "mission-cloud-demo",
        "status": "running",
        "db_connectivity": ok,
        "db_message": msg,
        "timestamp": int(time.time())
    })

@app.get("/health")
def health():
    return jsonify({"status": "healthy"}), 200

@app.get("/ready")
def ready():
    ok, msg = can_connect()
    if ok:
        return jsonify({"ready": True}), 200
    return jsonify({"ready": False, "reason": msg}), 503

if __name__ == "__main__":
    port = int(os.getenv("PORT", "8080"))
    app.run(host="0.0.0.0", port=port)
