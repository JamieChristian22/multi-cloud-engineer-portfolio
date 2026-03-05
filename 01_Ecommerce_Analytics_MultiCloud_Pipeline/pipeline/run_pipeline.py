import os, json
import pandas as pd
from sqlalchemy import text

from db import pg_engine
from quality_rules import run_quality_checks
from build_fact import build_fact_orders
from export import export_fact

BASE_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
OUT_DIR = os.path.join(BASE_DIR, "output")

def extract():
    eng = pg_engine()
    with eng.connect() as c:
        orders = pd.read_sql(text("SELECT * FROM orders ORDER BY order_date, order_id"), c)
        items = pd.read_sql(text("SELECT * FROM order_items"), c)
        customers = pd.read_sql(text("SELECT * FROM customers"), c)
        products = pd.read_sql(text("SELECT * FROM products"), c)
    return orders, items, customers, products

def main():
    orders, items, customers, products = extract()

    report = run_quality_checks(orders, items, customers, products)
    os.makedirs(OUT_DIR, exist_ok=True)
    with open(os.path.join(OUT_DIR, "data_quality_report.json"), "w", encoding="utf-8") as f:
        json.dump(report, f, indent=2, default=str)

    if not report["passed"]:
        raise SystemExit("Data quality checks failed. See output/data_quality_report.json")

    fact = build_fact_orders(orders, items, customers, products)
    exported = export_fact(fact, OUT_DIR)

    print("✅ Pipeline complete")
    print(f"Rows: {len(fact)}")
    print(f"Parquet: {exported['parquet']}")
    print(f"CSV: {exported['csv']}")
    print(f"Quality report: {os.path.join(OUT_DIR, 'data_quality_report.json')}")

if __name__ == "__main__":
    main()
